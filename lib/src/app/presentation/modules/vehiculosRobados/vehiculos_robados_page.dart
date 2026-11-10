part of '../pages.dart';

const _azulRobo = Color(0xFF0B2E59);
const _azulRoboClaro = Color(0xFF195BA6);
const _rojoRobo = Color(0xFFB3262D);

class VehiculosRobadosPage extends GetView<VehiculoRobadoController> {
  const VehiculosRobadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          'ALERTA DE VEHÍCULOS ROBADOS',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        backgroundColor: _azulRobo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.cargarRegistros,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _buildIntro()),
                    SliverToBoxAdapter(child: _buildSearchAndFilter()),
                    Obx(() {
                      if (controller.cargando.value &&
                          controller.registros.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (controller.error.value != null) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(controller.error.value!,
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 12),
                                OutlinedButton.icon(
                                  onPressed: controller.cargarRegistros,
                                  icon: const Icon(Icons.refresh_rounded),
                                  label: const Text('Reintentar'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final items = controller.registrosFiltrados;
                      if (items.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: _buildEmptyState(
                            controller.registros.isEmpty,
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        sliver: SliverList.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              _buildRecordCard(context, items[index]),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openForm(context),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Registrar vehículo robado',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _rojoRobo,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: _azulRobo.withValues(alpha: .22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntro() => Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [_azulRobo, _azulRoboClaro],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _azulRobo.withValues(alpha: .18),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline_rounded, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'La información se guarda únicamente en este dispositivo. '
                'Este registro no constituye una denuncia oficial ni genera '
                'una alerta para otros ciudadanos.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildSearchAndFilter() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.busqueda.value = value,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'Buscar por placa',
                prefixIcon: const Icon(Icons.search_rounded, color: _azulRobo),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.tipoFiltro.value,
                decoration: InputDecoration(
                  labelText: 'Filtrar por tipo de vehículo',
                  prefixIcon:
                      const Icon(Icons.filter_list_rounded, color: _azulRobo),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Todos', ...VehiculoRobadoController.tipos]
                    .map((tipo) =>
                        DropdownMenuItem(value: tipo, child: Text(tipo)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) controller.tipoFiltro.value = value;
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildEmptyState(bool sinRegistros) => Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.directions_car_outlined,
                  size: 58, color: Colors.blueGrey.shade200),
              const SizedBox(height: 12),
              Text(
                sinRegistros
                    ? 'Aún no tienes registros locales'
                    : 'No hay resultados para esta búsqueda',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _azulRobo,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (sinRegistros) ...[
                const SizedBox(height: 6),
                const Text(
                  'Registra los datos para consultarlos en este dispositivo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ],
          ),
        ),
      );

  Widget _buildRecordCard(
    BuildContext context,
    VehiculoRobadoRegistro registro,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showDetails(context, registro),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _azulRobo.withValues(alpha: .08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            _VehiclePhoto(path: registro.fotoPath, width: 110, height: 142),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            registro.placa,
                            style: const TextStyle(
                              color: _azulRobo,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.blueGrey),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${registro.marca} ${registro.modelo}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 3),
                    Text('${registro.color} · ${registro.tipo}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 8),
                    _RecordLine(
                      icon: Icons.calendar_month_outlined,
                      text: '${registro.fechaRobo} · ${registro.horaRobo}',
                    ),
                    const SizedBox(height: 4),
                    _RecordLine(
                      icon: Icons.location_on_outlined,
                      text: registro.ubicacionTexto,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: _azulRobo.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        registro.estado,
                        style: const TextStyle(
                          color: _azulRobo,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context, {
    VehiculoRobadoRegistro? registro,
  }) async {
    await Get.to(() => VehiculoRobadoFormPage(registroInicial: registro));
  }

  void _showDetails(
    BuildContext context,
    VehiculoRobadoRegistro registro,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * .88,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F6F9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: _VehiclePhoto(
                  path: registro.fotoPath,
                  width: double.infinity,
                  height: 210,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '${registro.marca} ${registro.modelo}',
                style: const TextStyle(
                  color: _azulRobo,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Placa ${registro.placa} · ${registro.tipo}',
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),
              _detailRow('Color / año', '${registro.color} / ${registro.anio}'),
              _detailRow('Robo', '${registro.fechaRobo} · ${registro.horaRobo}'),
              _detailRow('Lugar', registro.ubicacionTexto),
              _detailRow('Referencia', registro.lugar),
              _detailRow(
                'GPS',
                registro.latitud == null
                    ? 'Sin ubicación GPS'
                    : '${registro.latitud}, ${registro.longitud}',
              ),
              _detailRow('Contacto', registro.contactoNombre),
              _detailRow('Teléfono', registro.contactoTelefono),
              _detailRow(
                'Características',
                registro.descripcion.isEmpty
                    ? 'Sin información adicional'
                    : registro.descripcion,
              ),
              _detailRow('Estado', registro.estado),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _share(registro),
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Compartir'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _openForm(context, registro: registro);
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _azulRobo,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              TextButton.icon(
                onPressed: () =>
                    _confirmDelete(context, sheetContext, registro),
                icon: const Icon(Icons.delete_outline, color: _rojoRobo),
                label: const Text('Eliminar registro',
                    style: TextStyle(color: _rojoRobo)),
              ),
              const Text(
                'Información local no verificada. No constituye una denuncia oficial.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 112,
              child: Text(label,
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w600)),
            ),
            Expanded(
                child:
                    Text(value, style: const TextStyle(color: _azulRobo))),
          ],
        ),
      );

  Future<void> _confirmDelete(
    BuildContext pageContext,
    BuildContext sheetContext,
    VehiculoRobadoRegistro registro,
  ) async {
    final confirmar = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Eliminar registro'),
        content: Text('¿Deseas eliminar el vehículo con placa ${registro.placa}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: _rojoRobo),
            child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmar != true) return;
    try {
      await controller.eliminarRegistro(registro);
      if (sheetContext.mounted) Navigator.pop(sheetContext);
      Get.snackbar('Registro eliminado', 'Se eliminó del almacenamiento local.');
    } catch (_) {
      Get.snackbar('No se pudo eliminar', 'Inténtalo nuevamente.');
    }
  }

  Future<void> _share(VehiculoRobadoRegistro registro) async {
    final ubicacion = registro.ubicacionTexto.isEmpty
        ? 'No especificado'
        : registro.ubicacionTexto;
    final gps = registro.latitud == null
        ? ''
        : '\nGPS: ${registro.latitud}, ${registro.longitud}';
    final message = [
      'INFORMACIÓN NO VERIFICADA · NO ES UNA DENUNCIA OFICIAL',
      'Registro local de vehículo robado',
      'Placa: ${registro.placa}',
      'Vehículo: ${registro.marca} ${registro.modelo} (${registro.anio})',
      'Tipo y color: ${registro.tipo}, ${registro.color}',
      'Fecha y hora: ${registro.fechaRobo}, ${registro.horaRobo}',
      'Lugar: $ubicacion',
      if (registro.lugar.isNotEmpty) 'Referencia: ${registro.lugar}',
      gps,
      'Contacto: ${registro.contactoNombre} · ${registro.contactoTelefono}',
      'Esta información no ha sido verificada por la Policía Nacional.',
    ].where((line) => line.isNotEmpty).join('\n');
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: message,
          subject: 'Información no verificada de vehículo',
        ),
      );
    } catch (_) {
      Get.snackbar('No se pudo compartir', 'Inténtalo nuevamente.');
    }
  }
}

class VehiculoRobadoFormPage extends StatefulWidget {
  const VehiculoRobadoFormPage({super.key, this.registroInicial});

  final VehiculoRobadoRegistro? registroInicial;

  @override
  State<VehiculoRobadoFormPage> createState() =>
      _VehiculoRobadoFormPageState();
}

class _VehiculoRobadoFormPageState extends State<VehiculoRobadoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  late final VehiculoRobadoController _controller;
  late final TextEditingController _placa;
  late final TextEditingController _marca;
  late final TextEditingController _modelo;
  late final TextEditingController _anio;
  late final TextEditingController _color;
  late final TextEditingController _descripcion;
  late final TextEditingController _provincia;
  late final TextEditingController _ciudad;
  late final TextEditingController _lugar;
  late final TextEditingController _nombre;
  late final TextEditingController _telefono;

  String _tipo = VehiculoRobadoController.tipos.first;
  DateTime _fechaRobo = DateTime.now();
  TimeOfDay _horaRobo = TimeOfDay.now();
  String? _fotoPath;
  String? _fotoNueva;
  double? _latitud;
  double? _longitud;
  bool _guardando = false;
  bool _fotoGuardada = false;

  VehiculoRobadoRegistro? get _inicial => widget.registroInicial;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<VehiculoRobadoController>();
    final item = _inicial;
    _placa = TextEditingController(text: item?.placa ?? '');
    _marca = TextEditingController(text: item?.marca ?? '');
    _modelo = TextEditingController(text: item?.modelo ?? '');
    _anio = TextEditingController(text: item?.anio ?? '');
    _color = TextEditingController(text: item?.color ?? '');
    _descripcion = TextEditingController(text: item?.descripcion ?? '');
    _provincia = TextEditingController(text: item?.provincia ?? '');
    _ciudad = TextEditingController(text: item?.ciudad ?? '');
    _lugar = TextEditingController(text: item?.lugar ?? '');
    _nombre = TextEditingController(text: item?.contactoNombre ?? '');
    _telefono = TextEditingController(text: item?.contactoTelefono ?? '');
    if (item != null) {
      _tipo = item.tipo;
      _fotoPath = item.fotoPath;
      _latitud = item.latitud;
      _longitud = item.longitud;
      _fechaRobo = DateTime.tryParse(item.fechaRobo) ?? DateTime.now();
      final timeParts = item.horaRobo.split(':');
      if (timeParts.length == 2) {
        _horaRobo = TimeOfDay(
          hour: int.tryParse(timeParts[0]) ?? 0,
          minute: int.tryParse(timeParts[1]) ?? 0,
        );
      }
    }
  }

  @override
  void dispose() {
    for (final field in [
      _placa,
      _marca,
      _modelo,
      _anio,
      _color,
      _descripcion,
      _provincia,
      _ciudad,
      _lugar,
      _nombre,
      _telefono,
    ]) {
      field.dispose();
    }
    if (_fotoNueva != null &&
        !_fotoGuardada &&
        !_guardando &&
        _fotoNueva != _inicial?.fotoPath) {
      _controller.eliminarArchivoLocal(_fotoNueva);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = _inicial != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(editando ? 'Editar registro' : 'Registrar vehículo'),
        backgroundColor: _azulRobo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _formSection(
              title: 'Información del vehículo',
              icon: Icons.directions_car_filled_outlined,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _tipo,
                  decoration: _inputDecoration('Tipo de vehículo',
                      Icons.category_outlined),
                  items: VehiculoRobadoController.tipos
                      .map((tipo) =>
                          DropdownMenuItem(value: tipo, child: Text(tipo)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _tipo = value ?? _tipo),
                ),
                const SizedBox(height: 12),
                _textField(_placa, 'Placa', Icons.badge_outlined,
                    requiredField: true,
                    capitalization: TextCapitalization.characters,
                    maxLength: 10),
                _textField(_marca, 'Marca', Icons.factory_outlined,
                    requiredField: true),
                _textField(_modelo, 'Modelo', Icons.directions_car_outlined,
                    requiredField: true),
                _textField(_anio, 'Año', Icons.event_outlined,
                    requiredField: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    validator: _validarAnio),
                _textField(_color, 'Color', Icons.palette_outlined,
                    requiredField: true),
                _textField(
                  _descripcion,
                  'Descripción o características adicionales',
                  Icons.notes_rounded,
                  maxLines: 3,
                ),
              ],
            ),
            _formSection(
              title: 'Información del robo',
              icon: Icons.location_on_outlined,
              children: [
                _dateTimeControls(),
                _textField(_provincia, 'Provincia', Icons.map_outlined,
                    requiredField: true),
                _textField(_ciudad, 'Ciudad', Icons.location_city_outlined,
                    requiredField: true),
                _textField(
                  _lugar,
                  'Dirección o referencia',
                  Icons.place_outlined,
                  requiredField: true,
                  maxLines: 2,
                ),
                _gpsButton(),
              ],
            ),
            _formSection(
              title: 'Fotografía del vehículo',
              icon: Icons.photo_camera_outlined,
              children: [_photoPicker()],
            ),
            _formSection(
              title: 'Información de contacto',
              icon: Icons.person_outline_rounded,
              children: [
                _textField(_nombre, 'Nombre de quien registra',
                    Icons.person_outline_rounded,
                    requiredField: true),
                _textField(_telefono, 'Número de contacto',
                    Icons.phone_iphone_rounded,
                    requiredField: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    validator: _validarTelefono),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 16),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4F3),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _rojoRobo.withValues(alpha: .2)),
              ),
              child: const Text(
                'Este registro se guarda solo en el dispositivo. No es una denuncia oficial ni se transmite a la Policía o a otros ciudadanos.',
                style: TextStyle(
                    color: _rojoRobo, fontSize: 12, height: 1.4),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _guardando ? null : _guardar,
              icon: _guardando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save_rounded),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(editando ? 'Guardar cambios' : 'Guardar registro',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _azulRobo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) =>
      Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _azulRobo.withValues(alpha: .07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: _azulRoboClaro),
                const SizedBox(width: 9),
                Text(title,
                    style: const TextStyle(
                        color: _azulRobo,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 14),
            ...children.map((child) => Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: child,
                )),
          ],
        ),
      );

  InputDecoration _inputDecoration(String label, IconData icon) =>
      InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _azulRoboClaro),
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
        ),
      );

  Widget _textField(
    TextEditingController field,
    String label,
    IconData icon, {
    bool requiredField = false,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization capitalization = TextCapitalization.words,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: field,
        textCapitalization: capitalization,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        validator: validator ??
            (requiredField
                ? (value) => value == null || value.trim().isEmpty
                    ? 'Este campo es obligatorio'
                    : null
                : null),
        decoration: _inputDecoration(label, icon).copyWith(counterText: ''),
      );

  Widget _dateTimeControls() => Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _seleccionarFecha,
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text(_fechaTexto),
              style: OutlinedButton.styleFrom(
                foregroundColor: _azulRobo,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _seleccionarHora,
              icon: const Icon(Icons.access_time_rounded),
              label: Text(_horaRobo.format(context)),
              style: OutlinedButton.styleFrom(
                foregroundColor: _azulRobo,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      );

  String get _fechaTexto =>
      '${_fechaRobo.year.toString().padLeft(4, '0')}-'
      '${_fechaRobo.month.toString().padLeft(2, '0')}-'
      '${_fechaRobo.day.toString().padLeft(2, '0')}';

  Future<void> _seleccionarFecha() async {
    final seleccion = await showDatePicker(
      context: context,
      initialDate: _fechaRobo,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'EC'),
    );
    if (seleccion != null) setState(() => _fechaRobo = seleccion);
  }

  Future<void> _seleccionarHora() async {
    final seleccion =
        await showTimePicker(context: context, initialTime: _horaRobo);
    if (seleccion != null) setState(() => _horaRobo = seleccion);
  }

  Widget _gpsButton() => OutlinedButton.icon(
        onPressed: _obtenerGps,
        icon: Icon(
          _latitud == null ? Icons.my_location_rounded : Icons.location_on,
          color: _azulRobo,
        ),
        label: Text(
          _latitud == null
              ? 'Adjuntar ubicación GPS (opcional)'
              : 'GPS: ${_latitud!.toStringAsFixed(5)}, '
                  '${_longitud!.toStringAsFixed(5)}',
          maxLines: 2,
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: _azulRobo,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        ),
      );

  Future<void> _obtenerGps() async {
    try {
      final position = await _controller.obtenerUbicacionActual();
      if (!mounted) return;
      setState(() {
        _latitud = position.$1;
        _longitud = position.$2;
      });
    } catch (error) {
      if (mounted) {
        Get.snackbar('Ubicación no disponible', error.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Widget _photoPicker() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_fotoPath != null && File(_fotoPath!).existsSync())
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    File(_fotoPath!),
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton.filled(
                    tooltip: 'Eliminar fotografía',
                    onPressed: _quitarFoto,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: .95),
                        foregroundColor: _rojoRobo),
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              height: 118,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_filled_outlined,
                      size: 38, color: Colors.blueGrey),
                  SizedBox(height: 7),
                  Text('Añade una fotografía del vehículo'),
                ],
              ),
            ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _seleccionarFoto(ImageSource.camera),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Tomar foto'),
              ),
              OutlinedButton.icon(
                onPressed: () => _seleccionarFoto(ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Elegir de galería'),
              ),
            ],
          ),
        ],
      );

  Future<void> _quitarFoto() async {
    final fotoNueva = _fotoNueva;
    setState(() {
      _fotoPath = null;
      _fotoNueva = null;
    });
    if (fotoNueva != null) {
      await _controller.eliminarArchivoLocal(fotoNueva);
    }
  }

  Future<void> _seleccionarFoto(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 82,
        maxWidth: 1600,
      );
      if (image == null) return;
      final localPath = await _controller.guardarFotografia(image);
      if (!mounted) {
        await _controller.eliminarArchivoLocal(localPath);
        return;
      }
      final fotoNuevaAnterior = _fotoNueva;
      setState(() {
        _fotoNueva = localPath;
        _fotoPath = localPath;
      });
      if (fotoNuevaAnterior != null) {
        await _controller.eliminarArchivoLocal(fotoNuevaAnterior);
      }
    } catch (_) {
      Get.snackbar(
        'No se pudo cargar la fotografía',
        'Revisa los permisos del dispositivo e inténtalo nuevamente.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String? _validarAnio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa el año del vehículo';
    }
    final year = int.tryParse(value);
    if (year == null ||
        year < 1900 ||
        year > DateTime.now().year + 1 ||
        value.length != 4) {
      return 'Ingresa un año válido';
    }
    return null;
  }

  String? _validarTelefono(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa un número de contacto';
    }
    if (value.trim().replaceAll(RegExp(r'\D'), '').length < 7) {
      return 'Ingresa un número de contacto válido';
    }
    return null;
  }

  Future<void> _guardar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    final original = _inicial;
    final time = _horaRobo;
    final now = DateTime.now();
    final record = VehiculoRobadoRegistro(
      id: original?.id ?? now.microsecondsSinceEpoch.toString(),
      tipo: _tipo,
      placa: _placa.text.trim().toUpperCase(),
      marca: _marca.text.trim(),
      modelo: _modelo.text.trim(),
      anio: _anio.text.trim(),
      color: _color.text.trim(),
      descripcion: _descripcion.text.trim(),
      fechaRobo: _fechaTexto,
      horaRobo:
          '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}',
      provincia: _provincia.text.trim(),
      ciudad: _ciudad.text.trim(),
      lugar: _lugar.text.trim(),
      contactoNombre: _nombre.text.trim(),
      contactoTelefono: _telefono.text.trim(),
      estado: 'Registro local',
      fechaCreacion: original?.fechaCreacion ?? now.toIso8601String(),
      latitud: _latitud,
      longitud: _longitud,
      fotoPath: _fotoPath,
    );
    try {
      await _controller.guardarRegistro(record);
      _fotoGuardada = true;
      if (!mounted) return;
      Get.back();
      Get.snackbar(
        'Registro guardado',
        'La información quedó almacenada en este dispositivo.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      if (mounted) {
        Get.snackbar(
          'No se pudo guardar',
          'Ocurrió un error al almacenar la información local.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }
}

class _VehiclePhoto extends StatelessWidget {
  const _VehiclePhoto({
    required this.path,
    required this.width,
    required this.height,
  });

  final String? path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final file = path == null ? null : File(path!);
    return SizedBox(
      width: width,
      height: height,
      child: file != null && file.existsSync()
          ? Image.file(file, fit: BoxFit.cover)
          : Container(
              color: const Color(0xFFE8EDF3),
              child: const Icon(
                Icons.directions_car_filled_outlined,
                size: 42,
                color: _azulRoboClaro,
              ),
            ),
    );
  }
}

class _RecordLine extends StatelessWidget {
  const _RecordLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 14, color: _azulRoboClaro),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text.isEmpty ? 'Lugar no disponible' : text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ),
        ],
      );
}
