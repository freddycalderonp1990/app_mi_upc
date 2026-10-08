part of '../custom_widgets.dart';

class ComboBusqueda<T> extends StatefulWidget {
  final String title;
  final ValueChanged<T?>? complete;
  final List<T> datos;
  final String hint;
  final String searchHint;
  final T? selectValue;
  final IconData? icon;
  final String? imgUrl;
  final bool showClearButton;
  final GlobalKey? openDropDownProgKey;
  final String? textSeleccioneUndato;
  final String? Function(T?)? validator;
  final String Function(T)? displayField;
  final void Function(T)? onChanged;

  const ComboBusqueda({
    super.key,
    this.complete,
    required this.datos,
    this.title = '',
    this.hint = 'Seleccione...',
    required this.searchHint,
    this.selectValue,
    this.icon,
    this.showClearButton = true,
    this.openDropDownProgKey,
    this.textSeleccioneUndato,
    this.imgUrl,
    this.validator,
    this.displayField,
    this.onChanged,
  });

  @override
  State<ComboBusqueda<T>> createState() => _ComboBusquedaState<T>();
}

class _ComboBusquedaState<T> extends State<ComboBusqueda<T>> {
  bool showX = false;

  final TextEditingController _userEditTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showX = _tieneSeleccion(widget.selectValue);
  }

  @override
  void didUpdateWidget(covariant ComboBusqueda<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool nuevoEstado = _tieneSeleccion(widget.selectValue);

    if (showX != nuevoEstado) {
      showX = nuevoEstado;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool mostrarBuscador = widget.datos.length > 5;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD7E2ED), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================
          // TÍTULO DEL NIVEL
          // ===================================================

          Row(
            children: [
              Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2FC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon ?? Icons.tune_rounded,
                  color: const Color(0xFF195BA6),
                  size: 15,
                ),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  widget.searchHint.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF4B6177),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ===================================================
          // COMBO
          // ===================================================
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: showX
                    ? const Color(0xFF8CAECE)
                    : const Color(0xFFCEDAE6),
                width: 1.2,
              ),
            ),
            child: DropdownSearch<T>(
              key: widget.openDropDownProgKey,

              selectedItem: widget.selectValue,

              compareFn: (item, selectedItem) => item == selectedItem,

              /*
               * Quitamos completamente el borde que DropdownSearch
               * agrega internamente.
               *
               * El borde ahora lo controla únicamente el Container.
               */
              decoratorProps: const DropDownDecoratorProps(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),

              validator:
              widget.validator ??
                      (value) {
                    if (value == null) {
                      return "EL ${widget.title} Es requerido";
                    }

                    return null;
                  },

              suffixProps: DropdownSuffixProps(
                clearButtonProps: ClearButtonProps(
                  isVisible: widget.showClearButton && showX,
                  color: const Color(0xFFB3263E),
                ),

                dropdownButtonProps: const DropdownButtonProps(
                  iconClosed: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF53677C),
                    size: 25,
                  ),
                  iconOpened: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Color(0xFF195BA6),
                    size: 25,
                  ),
                ),
              ),

              popupProps: PopupProps.dialog(
                showSelectedItems: true,
                disableFilter: false,
                fit: FlexFit.loose,
                showSearchBox: mostrarBuscador,

                searchFieldProps: getBusquedaPopup(),

                itemBuilder: (context, item, isDisabled, isSelected) {
                  return _customDesingDataPopop(
                    context,
                    item,
                    isDisabled,
                    isSelected,
                  );
                },

                dialogProps: DialogProps(
                  backgroundColor: const Color(0xFFF8FAFD),
                  barrierDismissible: true,
                  barrierLabel: 'Cerrar diálogo',
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 35,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),

              itemAsString: (item) {
                return _getDisplayText(item);
              },

              dropdownBuilder: (context, selectedItem) {
                return _customDropDownExample(context, selectedItem);
              },

              items: (filter, infiniteScrollProps) {
                return widget.datos;
              },

              onSelected: (value) {
                _userEditTextController.clear();

                final bool nuevoEstado = _tieneSeleccion(value);

                if (showX != nuevoEstado && mounted) {
                  setState(() {
                    showX = nuevoEstado;
                  });
                }

                widget.complete?.call(value);

                if (value != null) {
                  widget.onChanged?.call(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VALOR SELECCIONADO
  // ============================================================

  Widget _customDropDownExample(BuildContext context, T? item) {
    if (item == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
        child: Text(
          widget.textSeleccioneUndato ?? "Seleccione una opción",
          style: const TextStyle(
            color: Color(0xFF8996A5),
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final String texto = _getDisplayText(item);

    if (texto.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 7, 4, 7),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F2FC),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF195BA6),
              size: 20,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              texto.toUpperCase(),
              softWrap: true,
              style: const TextStyle(
                color: Color(0xFF203A54),
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // POPUP
  // ============================================================

  Widget _customDesingDataPopop(
      BuildContext context,
      T? item,
      bool isDisabled,
      bool isSelected,
      ) {
    if (item == null) {
      return const SizedBox.shrink();
    }

    final String texto = _getDisplayText(item);

    if (texto.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF195BA6) : Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF195BA6)
                : const Color(0xFFDDE5ED),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(.15)
                    : const Color(0xFFEAF2FB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isSelected
                    ? Icons.check_rounded
                    : (widget.icon ?? Icons.local_police_outlined),
                color: isSelected ? Colors.white : const Color(0xFF195BA6),
                size: 18,
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Text(
                texto.toUpperCase(),
                softWrap: true,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF2E455B),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                  height: 1.18,
                ),
              ),
            ),

            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUSCADOR
  // ============================================================

  TextFieldProps getBusquedaPopup() {
    return TextFieldProps(
      controller: _userEditTextController,
      decoration: InputDecoration(
        hintText: "Buscar ${widget.searchHint.toLowerCase()}...",

        hintStyle: const TextStyle(color: Color(0xFF96A3B1), fontSize: 12.5),

        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF195BA6),
          size: 20,
        ),

        suffixIcon: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Color(0xFF718092),
            size: 19,
          ),
          onPressed: () {
            _userEditTextController.clear();
          },
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD5E0EA)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF195BA6), width: 1.5),
        ),
      ),
    );
  }

  // ============================================================
  // MÉTODOS EXISTENTES
  // ============================================================

  Widget getOnlyDesing({
    required Widget icon,
    String titulo = '',
    Color colorTexto = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              titulo,
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
                color: colorTexto,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDesing({
    bool isSelect = false,
    IconData? icon,
    String titulo = '',
    bool selected = false,
    String? iconUrl,
    Color colorTexto = Colors.black,
  }) {
    final Widget iconWidget = getIcon(icon: icon, isSelecc: isSelect);

    return getOnlyDesing(
      icon: iconWidget,
      titulo: titulo,
      colorTexto: colorTexto,
    );
  }

  Widget getIcon({IconData? icon, bool isSelecc = false}) {
    final Widget wg = isSelecc
        ? const Icon(Icons.check_circle_rounded, color: Colors.white)
        : Icon(
      icon ?? Icons.description_outlined,
      color: AppColors.colorBotones,
    );

    return Padding(padding: const EdgeInsets.all(4), child: wg);
  }

  String _getDisplayText(T item) {
    if (widget.displayField != null) {
      return widget.displayField!(item);
    }

    return item.toString();
  }

  bool _tieneSeleccion(T? item) {
    if (item == null) {
      return false;
    }

    return _getDisplayText(item).trim().isNotEmpty;
  }

  @override
  void dispose() {
    _userEditTextController.dispose();
    super.dispose();
  }
}
