part of '../pages.dart';

const _azulDesaparecidos = Color(0xFF0B2E59);
const _azulClaroDesaparecidos = Color(0xFF195BA6);
const _rojoDesaparecidos = Color(0xFFB3262D);

class AlertasDesaparecidosPage
    extends GetView<AlertasDesaparecidosController> {
  const AlertasDesaparecidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final persona = controller.esPersona;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text(
          controller.titulo,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: _azulDesaparecidos,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.cargar,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _aviso(persona)),
                    SliverToBoxAdapter(child: _busqueda(persona)),
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
                                  onPressed: controller.cargar,
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
                          child: _vacio(persona, controller.registros.isEmpty),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        sliver: SliverList.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              _tarjeta(context, items[index], persona),
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
                  onPressed: () => _abrirFormulario(context),
                  icon: Icon(persona
                      ? Icons.person_search_rounded
                      : Icons.pets_rounded),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      persona
                          ? 'Registrar persona desaparecida'
                          : 'Registrar mascota desaparecida',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _rojoDesaparecidos,
                    foregroundColor: Colors.white,
                    elevation: 5,
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

  Widget _aviso(bool persona) => Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [_azulDesaparecidos, _azulClaroDesaparecidos],
          ),
          boxShadow: [
            BoxShadow(
              color: _azulDesaparecidos.withValues(alpha: .16),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.shield_outlined, color: Colors.white, size: 23),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                persona
                    ? 'Registro privado guardado solo en este dispositivo. No es una denuncia ni una búsqueda difundida. Si existe riesgo inmediato, contacta a los servicios oficiales de emergencia.'
                    : 'Registro privado guardado solo en este dispositivo. No se difunde a otros ciudadanos ni reemplaza el aviso a las autoridades o refugios locales.',
                style: const TextStyle(
                    color: Colors.white, fontSize: 12.5, height: 1.4),
              ),
            ),
          ],
        ),
      );

  Widget _busqueda(bool persona) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: TextField(
          onChanged: (value) => controller.busqueda.value = value,
          decoration: InputDecoration(
            hintText: persona
                ? 'Buscar por nombre o lugar'
                : 'Buscar por nombre, especie o lugar',
            prefixIcon:
                const Icon(Icons.search_rounded, color: _azulDesaparecidos),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );

  Widget _vacio(bool persona, bool sinRegistros) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                persona ? Icons.person_search_rounded : Icons.pets_rounded,
                size: 58,
                color: Colors.blueGrey.shade200,
              ),
              const SizedBox(height: 12),
              Text(
                sinRegistros
                    ? 'Aún no hay registros locales'
                    : 'No encontramos registros para esa búsqueda',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _azulDesaparecidos,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );

  Widget _tarjeta(
    BuildContext context,
    AlertaDesaparecidoRegistro registro,
    bool persona,
  ) {
    final encontrado = registro.estado == 'Encontrado';
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _detalle(context, registro, persona),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: encontrado
                ? Colors.green.withValues(alpha: .35)
                : _rojoDesaparecidos.withValues(alpha: .22),
          ),
          boxShadow: [
            BoxShadow(
              color: _azulDesaparecidos.withValues(alpha: .07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _FotoDesaparecido(
              path: registro.fotoPath,
              width: 102,
              height: 136,
              persona: persona,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            registro.nombre,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _azulDesaparecidos,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.blueGrey),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      persona
                          ? [
                              if (registro.edad.isNotEmpty)
                                '${registro.edad} años',
                              registro.genero,
                            ].where((value) => value.isNotEmpty).join(' · ')
                          : [
                              registro.tipo,
                              registro.raza,
                              registro.color,
                            ].where((value) => value.isNotEmpty).join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    _LineaDesaparecido(
                      icon: Icons.calendar_month_outlined,
                      texto: '${registro.fecha} · ${registro.hora}',
                    ),
                    const SizedBox(height: 4),
                    _LineaDesaparecido(
                      icon: Icons.location_on_outlined,
                      texto: registro.ubicacion,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: encontrado
                            ? Colors.green.withValues(alpha: .1)
                            : _rojoDesaparecidos.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        registro.estado,
                        style: TextStyle(
                          color:
                              encontrado ? Colors.green.shade800 : _rojoDesaparecidos,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
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

  Future<void> _abrirFormulario(
    BuildContext context, {
    AlertaDesaparecidoRegistro? registro,
  }) async {
    await Get.to(() => AlertaDesaparecidoFormPage(
          controller: controller,
          registroInicial: registro,
        ));
  }

  void _detalle(
    BuildContext context,
    AlertaDesaparecidoRegistro registro,
    bool persona,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * .9),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F6F9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
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
                child: _FotoDesaparecido(
                  path: registro.fotoPath,
                  width: double.infinity,
                  height: 210,
                  persona: persona,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                registro.nombre,
                style: const TextStyle(
                    color: _azulDesaparecidos,
                    fontSize: 21,
                    fontWeight: FontWeight.w900),
              ),
              _filaDetalle('Estado', registro.estado),
              if (persona) ...[
                _filaDetalle('Edad / género',
                    '${registro.edad.isEmpty ? 'No especificada' : registro.edad} / ${registro.genero.isEmpty ? 'No especificado' : registro.genero}'),
                _filaDetalle('Vestimenta', registro.vestimenta),
              ] else ...[
                _filaDetalle('Tipo', registro.tipo),
                _filaDetalle('Raza', registro.raza),
                _filaDetalle('Color / tamaño',
                    '${registro.color} / ${registro.tamano}'),
              ],
              _filaDetalle('Desaparición', '${registro.fecha} · ${registro.hora}'),
              _filaDetalle('Lugar', registro.ubicacion),
              _filaDetalle('Referencia', registro.lugar),
              _filaDetalle(
                'GPS',
                registro.latitud == null
                    ? 'Sin ubicación GPS'
                    : '${registro.latitud}, ${registro.longitud}',
              ),
              _filaDetalle('Contacto', registro.contactoNombre),
              _filaDetalle('Teléfono', registro.contactoTelefono),
              _filaDetalle('Características', registro.detalles),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _compartir(registro, persona),
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Compartir'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final actualizado = registro.copyWith(
                        estado: registro.estado == 'Encontrado'
                            ? 'Desaparecido'
                            : 'Encontrado',
                      );
                      try {
                        await controller.guardar(actualizado);
                        if (sheetContext.mounted) {
                          Navigator.pop(sheetContext);
                        }
                        Get.snackbar(
                          'Estado actualizado',
                          actualizado.estado == 'Encontrado'
                              ? 'Marcado como encontrado en este dispositivo.'
                              : 'El registro volvió a estado desaparecido.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } catch (_) {
                        Get.snackbar(
                            'No se pudo actualizar', 'Inténtalo de nuevo.');
                      }
                    },
                    icon: Icon(registro.estado == 'Encontrado'
                        ? Icons.undo_rounded
                        : Icons.check_circle_outline_rounded),
                    label: Text(registro.estado == 'Encontrado'
                        ? 'Reabrir'
                        : 'Marcar encontrado'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _abrirFormulario(context, registro: registro);
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _azulDesaparecidos,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () =>
                    _confirmarEliminacion(context, sheetContext, registro),
                icon: const Icon(Icons.delete_outline,
                    color: _rojoDesaparecidos),
                label: const Text('Eliminar registro',
                    style: TextStyle(color: _rojoDesaparecidos)),
              ),
              const Text(
                'Registro local no verificado. No se difunde ni constituye una denuncia oficial.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filaDetalle(String label, String value) => Padding(
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
                child: Text(value.isEmpty ? 'No especificado' : value,
                    style: const TextStyle(color: _azulDesaparecidos))),
          ],
        ),
      );

  Future<void> _confirmarEliminacion(
    BuildContext context,
    BuildContext sheetContext,
    AlertaDesaparecidoRegistro registro,
  ) async {
    final confirmar = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Eliminar registro'),
        content: Text('¿Deseas eliminar el registro de ${registro.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
                backgroundColor: _rojoDesaparecidos),
            child:
                const Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmar != true) return;
    try {
      await controller.eliminar(registro);
      if (sheetContext.mounted) Navigator.pop(sheetContext);
      Get.snackbar('Registro eliminado', 'Se eliminó del almacenamiento local.');
    } catch (_) {
      Get.snackbar('No se pudo eliminar', 'Inténtalo nuevamente.');
    }
  }

  Future<void> _compartir(
    AlertaDesaparecidoRegistro registro,
    bool persona,
  ) async {
    final mensaje = [
      'INFORMACIÓN NO VERIFICADA · REGISTRO PRIVADO DEL DISPOSITIVO',
      persona
          ? 'Persona registrada como desaparecida: ${registro.nombre}'
          : 'Mascota registrada como desaparecida: ${registro.nombre}',
      if (persona && registro.edad.isNotEmpty) 'Edad: ${registro.edad}',
      if (persona && registro.genero.isNotEmpty) 'Género: ${registro.genero}',
      if (registro.tipo.isNotEmpty) 'Tipo: ${registro.tipo}',
      if (registro.raza.isNotEmpty) 'Raza: ${registro.raza}',
      if (registro.color.isNotEmpty) 'Color: ${registro.color}',
      if (registro.vestimenta.isNotEmpty)
        'Vestimenta: ${registro.vestimenta}',
      if (registro.detalles.isNotEmpty)
        'Características: ${registro.detalles}',
      'Fecha y hora: ${registro.fecha} · ${registro.hora}',
      'Lugar: ${registro.ubicacion}',
      if (registro.latitud != null)
        'GPS: ${registro.latitud}, ${registro.longitud}',
      'Estado: ${registro.estado}',
      'Este registro no ha sido verificado ni difundido por la Policía Nacional.',
    ].join('\n');
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: mensaje,
          subject: 'Información no verificada de desaparición',
        ),
      );
    } catch (_) {
      Get.snackbar('No se pudo compartir', 'Inténtalo nuevamente.');
    }
  }
}

class AlertaDesaparecidoFormPage extends StatefulWidget {
  const AlertaDesaparecidoFormPage({
    super.key,
    required this.controller,
    this.registroInicial,
  });

  final AlertasDesaparecidosController controller;
  final AlertaDesaparecidoRegistro? registroInicial;

  @override
  State<AlertaDesaparecidoFormPage> createState() =>
      _AlertaDesaparecidoFormPageState();
}

class _AlertaDesaparecidoFormPageState
    extends State<AlertaDesaparecidoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  late final TextEditingController _nombre;
  late final TextEditingController _edad;
  late final TextEditingController _genero;
  late final TextEditingController _raza;
  late final TextEditingController _color;
  late final TextEditingController _tamano;
  late final TextEditingController _detalles;
  late final TextEditingController _vestimenta;
  late final TextEditingController _provincia;
  late final TextEditingController _ciudad;
  late final TextEditingController _lugar;
  late final TextEditingController _contacto;
  late final TextEditingController _telefono;

  String _tipo = 'Perro';
  String _fecha = _formatoFecha(DateTime.now());
  TimeOfDay _hora = TimeOfDay.now();
  String? _fotoPath;
  String? _fotoNueva;
  double? _latitud;
  double? _longitud;
  bool _guardando = false;
  bool _fotoGuardada = false;

  bool get _persona => widget.controller.esPersona;
  AlertaDesaparecidoRegistro? get _inicial => widget.registroInicial;

  static String _formatoFecha(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    final item = _inicial;
    _nombre = TextEditingController(text: item?.nombre ?? '');
    _edad = TextEditingController(text: item?.edad ?? '');
    _genero = TextEditingController(text: item?.genero ?? '');
    _raza = TextEditingController(text: item?.raza ?? '');
    _color = TextEditingController(text: item?.color ?? '');
    _tamano = TextEditingController(text: item?.tamano ?? '');
    _detalles = TextEditingController(text: item?.detalles ?? '');
    _vestimenta = TextEditingController(text: item?.vestimenta ?? '');
    _provincia = TextEditingController(text: item?.provincia ?? '');
    _ciudad = TextEditingController(text: item?.ciudad ?? '');
    _lugar = TextEditingController(text: item?.lugar ?? '');
    _contacto = TextEditingController(text: item?.contactoNombre ?? '');
    _telefono = TextEditingController(text: item?.contactoTelefono ?? '');
    if (item != null) {
      _tipo = item.tipo.isEmpty ? _tipo : item.tipo;
      _fecha = item.fecha;
      _fotoPath = item.fotoPath;
      _latitud = item.latitud;
      _longitud = item.longitud;
      final parts = item.hora.split(':');
      if (parts.length == 2) {
        _hora = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 0,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    }
  }

  @override
  void dispose() {
    for (final field in [
      _nombre,
      _edad,
      _genero,
      _raza,
      _color,
      _tamano,
      _detalles,
      _vestimenta,
      _provincia,
      _ciudad,
      _lugar,
      _contacto,
      _telefono,
    ]) {
      field.dispose();
    }
    if (_fotoNueva != null &&
        !_fotoGuardada &&
        !_guardando &&
        _fotoNueva != _inicial?.fotoPath) {
      widget.controller.eliminarFoto(_fotoNueva);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF4F6F9),
        appBar: AppBar(
          title: Text(_persona ? 'Registrar persona' : 'Registrar mascota'),
          backgroundColor: _azulDesaparecidos,
          foregroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
            children: [
              _seccion(
                _persona ? 'Datos de la persona' : 'Datos de la mascota',
                _persona ? Icons.person_outline_rounded : Icons.pets_rounded,
                [
                  _campo(_nombre,
                      _persona ? 'Nombre completo' : 'Nombre o referencia',
                      Icons.badge_outlined,
                      requerido: true),
                  if (_persona) ...[
                    _campo(_edad, 'Edad aproximada (opcional)',
                        Icons.cake_outlined,
                        keyboard: TextInputType.number),
                    _campo(_genero, 'Sexo o género (opcional)',
                        Icons.person_pin_outlined),
                    _campo(_vestimenta, 'Vestimenta al desaparecer',
                        Icons.checkroom_outlined,
                        maxLines: 2),
                  ] else ...[
                    DropdownButtonFormField<String>(
                      initialValue: _tipo,
                      decoration: _decoracion(
                          'Tipo de mascota', Icons.category_outlined),
                      items: const ['Perro', 'Gato', 'Ave', 'Otro']
                          .map((value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _tipo = value ?? _tipo),
                    ),
                    _campo(_raza, 'Raza (opcional)',
                        Icons.pets_outlined),
                    _campo(_edad, 'Edad aproximada (opcional)',
                        Icons.cake_outlined),
                    _campo(_color, 'Color y señas particulares',
                        Icons.palette_outlined,
                        requerido: true),
                    _campo(_tamano, 'Tamaño (opcional)',
                        Icons.straighten_rounded),
                  ],
                  _campo(_detalles, 'Características adicionales',
                      Icons.notes_rounded,
                      maxLines: 3),
                ],
              ),
              _seccion(
                'Fecha y lugar de desaparición',
                Icons.location_on_outlined,
                [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _seleccionarFecha,
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: Text(_fecha),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _seleccionarHora,
                          icon: const Icon(Icons.access_time_rounded),
                          label: Text(_hora.format(context)),
                        ),
                      ),
                    ],
                  ),
                  _campo(_provincia, 'Provincia', Icons.map_outlined,
                      requerido: true),
                  _campo(_ciudad, 'Ciudad o cantón',
                      Icons.location_city_outlined,
                      requerido: true),
                  _campo(_lugar, 'Último lugar visto / referencia',
                      Icons.place_outlined,
                      requerido: true,
                      maxLines: 2),
                  _gpsButton(),
                ],
              ),
              _seccion(
                'Fotografía',
                Icons.photo_camera_outlined,
                [_photoPicker()],
              ),
              _seccion(
                'Contacto de referencia',
                Icons.contact_phone_outlined,
                [
                  _campo(_contacto, 'Nombre de contacto',
                      Icons.person_outline_rounded,
                      requerido: true),
                  _campo(_telefono, 'Número de contacto',
                      Icons.phone_iphone_rounded,
                      requerido: true,
                      keyboard: TextInputType.phone,
                      validator: _validarTelefono),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4F3),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _rojoDesaparecidos.withValues(alpha: .2)),
                ),
                child: const Text(
                  'Los datos y fotos se guardan solo en el dispositivo. Compartir es una acción manual y la información no está verificada.',
                  style: TextStyle(
                      color: _rojoDesaparecidos, fontSize: 12, height: 1.4),
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
                  child: Text(
                    _inicial == null ? 'Guardar registro' : 'Guardar cambios',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _azulDesaparecidos,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _seccion(String titulo, IconData icono, List<Widget> children) =>
      Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _azulDesaparecidos.withValues(alpha: .07),
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
                Icon(icono, color: _azulClaroDesaparecidos),
                const SizedBox(width: 9),
                Text(titulo,
                    style: const TextStyle(
                        color: _azulDesaparecidos,
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

  InputDecoration _decoracion(String label, IconData icono) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono, color: _azulClaroDesaparecidos),
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDE4EC)),
        ),
      );

  Widget _campo(
    TextEditingController field,
    String label,
    IconData icono, {
    bool requerido = false,
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: field,
        keyboardType: keyboard,
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxLines,
        validator: validator ??
            (requerido
                ? (value) => value == null || value.trim().isEmpty
                    ? 'Completa este campo'
                    : null
                : null),
        decoration: _decoracion(label, icono),
      );

  Widget _gpsButton() => OutlinedButton.icon(
        onPressed: _obtenerGps,
        icon: Icon(
          _latitud == null
              ? Icons.my_location_rounded
              : Icons.location_on_rounded,
        ),
        label: Text(
          _latitud == null
              ? 'Adjuntar ubicación GPS (opcional)'
              : 'GPS: ${_latitud!.toStringAsFixed(5)}, '
                  '${_longitud!.toStringAsFixed(5)}',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: _azulDesaparecidos,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        ),
      );

  Future<void> _obtenerGps() async {
    try {
      final position = await widget.controller.obtenerGps();
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
                  child: Image.file(File(_fotoPath!),
                      width: double.infinity, height: 185, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 7,
                  right: 7,
                  child: IconButton.filled(
                    onPressed: _quitarFoto,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: .95),
                      foregroundColor: _rojoDesaparecidos,
                    ),
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              height: 112,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFDDE4EC)),
              ),
              child: Icon(
                _persona ? Icons.person_outline_rounded : Icons.pets_rounded,
                size: 40,
                color: Colors.blueGrey,
              ),
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _elegirFoto(ImageSource.camera),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Tomar foto'),
              ),
              OutlinedButton.icon(
                onPressed: () => _elegirFoto(ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Galería'),
              ),
            ],
          ),
        ],
      );

  Future<void> _quitarFoto() async {
    final path = _fotoNueva;
    setState(() {
      _fotoPath = null;
      _fotoNueva = null;
    });
    if (path != null) await widget.controller.eliminarFoto(path);
  }

  Future<void> _elegirFoto(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 82,
        maxWidth: 1600,
      );
      if (image == null) return;
      final path = await widget.controller.guardarFoto(image);
      if (!mounted) {
        await widget.controller.eliminarFoto(path);
        return;
      }
      final previous = _fotoNueva;
      setState(() {
        _fotoPath = path;
        _fotoNueva = path;
      });
      if (previous != null) await widget.controller.eliminarFoto(previous);
    } catch (_) {
      Get.snackbar(
        'No se pudo cargar la foto',
        'Revisa los permisos e inténtalo nuevamente.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _seleccionarFecha() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_fecha) ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => _fecha = _formatoFecha(date));
  }

  Future<void> _seleccionarHora() async {
    final time = await showTimePicker(context: context, initialTime: _hora);
    if (time != null) setState(() => _hora = time);
  }

  String? _validarTelefono(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa un número de contacto';
    }
    if (value.replaceAll(RegExp(r'\D'), '').length < 7) {
      return 'Ingresa un número de contacto válido';
    }
    return null;
  }

  Future<void> _guardar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    final now = DateTime.now();
    final time = _hora;
    final record = AlertaDesaparecidoRegistro(
      id: _inicial?.id ?? now.microsecondsSinceEpoch.toString(),
      categoria: widget.controller.categoria,
      nombre: _nombre.text.trim(),
      edad: _edad.text.trim(),
      genero: _genero.text.trim(),
      tipo: _persona ? '' : _tipo,
      raza: _raza.text.trim(),
      color: _color.text.trim(),
      tamano: _tamano.text.trim(),
      detalles: _detalles.text.trim(),
      vestimenta: _vestimenta.text.trim(),
      fecha: _fecha,
      hora: '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}',
      provincia: _provincia.text.trim(),
      ciudad: _ciudad.text.trim(),
      lugar: _lugar.text.trim(),
      contactoNombre: _contacto.text.trim(),
      contactoTelefono: _telefono.text.trim(),
      estado: _inicial?.estado ?? 'Desaparecido',
      fechaCreacion: _inicial?.fechaCreacion ?? now.toIso8601String(),
      latitud: _latitud,
      longitud: _longitud,
      fotoPath: _fotoPath,
    );
    try {
      await widget.controller.guardar(record);
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
        Get.snackbar('No se pudo guardar',
            'Ocurrió un error al guardar la información local.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }
}

class _FotoDesaparecido extends StatelessWidget {
  const _FotoDesaparecido({
    required this.path,
    required this.width,
    required this.height,
    required this.persona,
  });

  final String? path;
  final bool persona;
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
              child: Icon(
                persona ? Icons.person_search_rounded : Icons.pets_rounded,
                size: 42,
                color: _azulClaroDesaparecidos,
              ),
            ),
    );
  }
}

class _LineaDesaparecido extends StatelessWidget {
  const _LineaDesaparecido({required this.icon, required this.texto});
  final IconData icon;
  final String texto;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 14, color: _azulClaroDesaparecidos),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              texto.isEmpty ? 'Lugar no disponible' : texto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ),
        ],
      );
}
