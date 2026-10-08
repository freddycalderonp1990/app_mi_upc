part of 'custom_widgets.dart';

class ContadorTextArea extends StatefulWidget {
  final int maxLength;
  final String? initialText;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextEditingController? controller; // 👈 Nuevo parámetro

  const ContadorTextArea({
    Key? key,
    this.maxLength = 200,
    this.initialText,
    this.onChanged,
    this.hintText = 'Escribe tu mensaje aquí...',
    this.controller,
  }) : super(key: key);

  @override
  _ContadorTextAreaState createState() => _ContadorTextAreaState();
}

class _ContadorTextAreaState extends State<ContadorTextArea> {
  late TextEditingController _controller;
  int _caracteresUsados = 0;
  bool _isFocused = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Usa el controller externo si existe, si no crea uno nuevo
    _controller = widget.controller ?? TextEditingController(text: widget.initialText ?? '');
    _caracteresUsados = _controller.text.length;

    _controller.addListener(() {
      setState(() {
        _caracteresUsados = _controller.text.length;
      });
      widget.onChanged?.call(_controller.text);
    });

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // solo lo eliminamos si lo creamos aquí
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_isFocused ? 20 : 15),
        boxShadow: _isFocused
            ? [BoxShadow(color: Colors.transparent, blurRadius: 10)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLength: widget.maxLength,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.edit, color: Colors.blue[900]),
              hintText: widget.hintText,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: _isFocused || _caracteresUsados > 0 ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Text(
                '${_caracteresUsados}/${widget.maxLength}',
                style: TextStyle(
                  fontSize: 12,
                  color: _caracteresUsados > widget.maxLength
                      ? Colors.red
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
