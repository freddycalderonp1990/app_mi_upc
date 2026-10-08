part of '../pages.dart';

class AlertasDelitosPage extends GetView<AlertasDelitosController> {
  const AlertasDelitosPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.mostrarDialogoTerminos(context);

    return WorkAreaItemsPageWidget(
      titleAppBar: controller.nombreModulo,
      peticionServer: controller.peticionServerState,
      contenido: getContenido(),
      foto64: controller.imagenModulo,
      btnAtras: true,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.anchoP(3),
        vertical: responsive.altoP(1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConnectionStatusBanner(
            status: controller.status,
            onInit: controller.connectionStatusController,
          ),
         _headerTecnico(responsive),
          SizedBox(height: responsive.altoP(0.6)),
          _formCard(responsive),
          SizedBox(height: responsive.altoP(2.0)),
          _btnGuardar(responsive),
          SizedBox(height: responsive.altoP(2.5)),
        ],
      ),
    );
  }

  Widget _headerTecnico(ResponsiveUtil responsive) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.anchoP(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/img/escpolicia.png', // cambia por tu ruta real
            height: responsive.altoP(10),
            fit: BoxFit.contain,
          ),
          Text(
            "POLICIA NACIONAL DEL ECUADOR",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF0A3D78),
              fontSize: responsive.diagonalP(2.2),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),

          Text(
            "Registro de alerta ciudadana",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF5E728A),
              fontSize: responsive.diagonalP(1.65),
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
          SizedBox(height: responsive.altoP(0.6)),
        ],
      ),
    );
  }

  Widget _formCard(ResponsiveUtil responsive) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(responsive.anchoP(4)),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                icon: Icons.assignment_outlined,
                title: "Datos del evento",
                subtitle:
                "Seleccione el tipo de evento y complete la información.",
                responsive: responsive,
              ),
              Obx(() {
                if (controller.cargandoEventosApi.value) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                return ComboBusqueda<CatalogoModel>(
                  title: "Tipo de evento",
                  selectValue: controller.idEventoApiSeleccionado.value == 0
                      ? null
                      : controller.listEventosApi.firstWhereOrNull(
                        (c) => c.id == controller.idEventoApiSeleccionado.value,
                  ),
                  datos: controller.listEventosApi,
                  displayField: (item) => item.descripcion,
                  searchHint: "Seleccione el tipo de evento",
                  textSeleccioneUndato: "Seleccione un evento",
                  complete: (value) {
                    if (value != null) {
                      controller.seleccionarEventoCatalogo(value);
                    }
                  },
                );
              }),
              SizedBox(height: responsive.altoP(1.5)),
              _fechaEventoField(responsive, Get.context!),
              SizedBox(height: responsive.altoP(1.5)),
              _labelCampo("Descripción", responsive),
              const SizedBox(height: 8),
              Container(
                child: ContadorTextArea(
                  maxLength: 250,
                  controller: controller.descripcionController,
                  onChanged: (texto) {},
                ),
              ),

              _labelCampo("Referencia del lugar", responsive),
              const SizedBox(height: 8),
              _textFieldElegant(
                controller: controller.referenciaController,
                hint: "Ej.: Calles Japón y Eloy Alfaro, frente a farmacia",
                icon: Icons.place_outlined,
                maxLines: 3,
              ),
              _sectionTitle(
                icon: Icons.touch_app,
                title: "Ubicación del evento",
                subtitle:
                "Toque el mapa para seleccionar la ubicación exacta de la evento.",
                responsive: responsive,
              ),
              SizedBox(height: responsive.altoP(1.0)),
              Obx(() {
                final bool tieneUbicacionEvento =
                    controller.latitudEvento.value != 0.0 &&
                        controller.longitudEvento.value != 0.0;

                final bool tieneUbicacionDispositivo =
                    controller.latitudDispositivo.value != 0.0 &&
                        controller.longitudDispositivo.value != 0.0;

                if (!tieneUbicacionEvento && !tieneUbicacionDispositivo) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FBFD),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD7E3F1)),
                    ),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 14),
                        const Text(
                          "Obteniendo ubicación actual...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF0A2E5C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await controller.obtenerUbicacionInicial();
                          },
                          icon: const Icon(Icons.my_location),
                          label: const Text("Reintentar ubicación"),
                        ),
                      ],
                    ),
                  );
                }

                final double lat = tieneUbicacionEvento
                    ? controller.latitudEvento.value
                    : controller.latitudDispositivo.value;

                final double lng = tieneUbicacionEvento
                    ? controller.longitudEvento.value
                    : controller.longitudDispositivo.value;

                return SeleccionMapaEventoWidget(
                  latInicial: lat,
                  lngInicial: lng,
                  onUbicacionSeleccionada: (latitud, longitud) {
                    controller.actualizarUbicacionEvento(latitud, longitud);
                  },
                );
              }),
              SizedBox(height: responsive.altoP(1.2)),
             // _btnUsarMiUbicacion(responsive),
             // _panelCoordenadasSeleccionadas(responsive),
            //  SizedBox(height: responsive.altoP(2.0)),
              Obx(() {
                return AdjuntoEventoWidget(
                  archivo: controller.adjuntoSeleccionado.value,
                  cargando: controller.cargandoAdjunto.value,
                  onTomarFoto: () async {
                    await controller.tomarFoto();
                  },
                  onGrabarVideo: () async {
                    await controller.grabarVideo();
                  },
                  onSeleccionarArchivo: () async {
                    await controller.seleccionarArchivoAdjunto();
                  },
                  onEliminar: () {
                    controller.eliminarAdjunto();
                  },
                );
              }),
              SizedBox(height: responsive.altoP(1.6)),
              _labelCampo("Seudónimo / nombre referencial", responsive),
              const SizedBox(height: 8),
              _textFieldElegant(

                controller: controller.seudonimoController,
                hint: "Ej.: Anónimo",
                icon: Icons.badge_outlined,
                maxLength: 30
              ),
              SizedBox(height: responsive.altoP(1.5)),
              _labelCampo("Número telefónico", responsive),
              const SizedBox(height: 8),
              _textFieldElegant(
                controller: controller.telefonoController,
                hint: "Ej.: 0999999999",
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                maxLength: 10
              ),
              SizedBox(height: responsive.altoP(1.5)),
              _labelCampo("Correo electrónico", responsive),
              const SizedBox(height: 8),
              _textFieldElegant(
                controller: controller.correoController,
                hint: "Ej.: usuario@correo.com",
                icon: Icons.alternate_email_outlined,
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
              ),
               SizedBox(height: responsive.altoP(1.8)),
              //_panelInformativoEstado(responsive),
            ],
          ),
        ),
      ),
    );
  }
  Widget _btnUsarMiUbicacion(ResponsiveUtil responsive) {
    return ElevatedButton.icon(
      onPressed: () async {
        await controller.obtenerUbicacionInicial();
      },
      icon: const Icon(Icons.my_location),
      label: const Text("Usar mi ubicación actual"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF195BA6),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
  Widget _sectionTitle({
    required IconData icon,
    required String title,
    required String subtitle,
    required ResponsiveUtil responsive,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(18),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFF195BA6).withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF195BA6), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF0A2E5C),
                    fontWeight: FontWeight.w800,
                    fontSize: responsive.diagonalP(1.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: responsive.diagonalP(1.35),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelCampo(String text, ResponsiveUtil responsive) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: responsive.diagonalP(1.55),
        color: const Color(0xFF0A2E5C),
      ),
    );
  }

  BoxDecoration _inputDecorationBox() {
    return BoxDecoration(
      color: const Color(0xFFF9FBFD),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFD7E3F1)),
    );
  }
  Widget _textFieldElegant({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLength = 500,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final FocusNode focusNode = FocusNode();
    final ValueNotifier<bool> hasFocus = ValueNotifier(false);

    focusNode.addListener(() {
      hasFocus.value = focusNode.hasFocus;
    });

    return ValueListenableBuilder<bool>(
      valueListenable: hasFocus,
      builder: (_, focused, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FBFD),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: focused
                  ? const Color(0xFF195BA6)
                  : const Color(0xFFD7E3F1),
              width: focused ? 2 : 1,
            ),
            boxShadow: focused
                ? [
              BoxShadow(
                color: const Color(0xFF195BA6).withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
            ]
                : [],
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            style: const TextStyle(
              color: Color(0xFF243447),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.blueGrey.shade400),
              prefixIcon: Icon(
                icon,
                color: focused
                    ? const Color(0xFF195BA6)
                    : Colors.blueGrey.shade400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _panelCoordenadasSeleccionadas(ResponsiveUtil responsive) {
    return Obx(() {
      final lat = controller.latitudEvento.value;
      final lng = controller.longitudEvento.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD6E4F3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF195BA6).withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.my_location_rounded,
                color: Color(0xFF195BA6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Latitud evento: ${lat.toStringAsFixed(7)}\nLongitud evento: ${lng.toStringAsFixed(7)}',
                style: TextStyle(
                  fontSize: responsive.diagonalP(1.35),
                  color: const Color(0xFF0A2E5C),
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _panelInformativoEstado(ResponsiveUtil responsive) {
    return Obx(() {
      final online = controller.status.value == ConnectionStatus.online;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: online
              ? const Color(0xFFEAF7EE)
              : const Color(0xFFFFF4E8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: online
                ? const Color(0xFFB8DFC2)
                : const Color(0xFFF2D0A4),
          ),
        ),
        child: Row(
          children: [
            Icon(
              online ? Icons.wifi_tethering : Icons.wifi_off_rounded,
              color: online
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFC47A12),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                online
                    ? "Conexión activa. El evento será enviado al servidor institucional."
                    : "Sin conexión. Verifique internet antes de realizar el registro.",
                style: TextStyle(
                  color: online
                      ? const Color(0xFF1E5F2E)
                      : const Color(0xFF9A5B00),
                  fontWeight: FontWeight.w600,
                  fontSize: responsive.diagonalP(1.35),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _btnGuardar(ResponsiveUtil responsive) {
    return Obx(() {
      final online = controller.status.value == ConnectionStatus.online;
      final isLoading = controller.creandoEvento.value;
      final isPressed = controller.btnPressed.value;

      return AbsorbPointer(
        absorbing: isLoading,
        child: GestureDetector(
          onTapDown: (_) {
            if (!isLoading) {
              controller.btnPressed.value = true;
            }
          },
          onTapUp: (_) async {
            await Future.delayed(const Duration(milliseconds: 90));
            controller.btnPressed.value = false;

            if (isLoading) return;

            if (!online) {
              DialogosAwesome.getError(
                descripcion:
                "No tiene conexión a internet para realizar el registro.",
              );
              return;
            }

            await controller.crearEvento();
          },
          onTapCancel: () => controller.btnPressed.value = false,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: isLoading ? 0.90 : 1.0,
            child: AnimatedScale(
              scale: isPressed ? 0.98 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isLoading
                        ? [
                      Colors.blueGrey,
                      Colors.blueGrey.shade700,
                    ]
                        : const [
                      Color(0xFF195BA6),
                      Color(0xFF0A2E5C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isPressed ? 0.12 : 0.22),
                      blurRadius: isPressed ? 6 : 14,
                      offset: Offset(0, isPressed ? 2 : 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isLoading
                          ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.6,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Icon(
                        Icons.save_rounded,
                        key: ValueKey('icon'),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        isLoading ? "REGISTRANDO EVENTO..." : "GUARDAR EVENTO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: responsive.diagonalP(1.7),
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
  Widget _fechaEventoField(ResponsiveUtil responsive, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelCampo("Fecha y hora del evento", responsive),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await controller.seleccionarFechaEvento(context);
          },
          child: Container(
            decoration: _inputDecorationBox(),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller.fechaEventoController,
                style: const TextStyle(
                  color: Color(0xFF243447),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Seleccione fecha y hora",
                  hintStyle: TextStyle(color: Colors.blueGrey.shade400),
                  prefixIcon: const Icon(
                    Icons.event_outlined,
                    color: Color(0xFF195BA6),
                  ),
                  suffixIcon: const Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFF195BA6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogoTerminos1800Delito extends GetView<AlertasDelitosController> {
  const DialogoTerminos1800Delito();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: responsive.anchoP(2),
        ),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 900,
            maxHeight: responsive.altoP(90),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FB),
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===================== CABECERA =====================
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.anchoP(4),
                    vertical: responsive.altoP(2),
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF08285C),
                        Color(0xFF204B8F),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFC9141B),
                            width: 3,
                          ),
                        ),
                        child: Text(
                          "1800-DELITO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFC9141B),
                            fontSize: responsive.diagonalP(2.8),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: responsive.altoP(1.4)),
                      Text(
                        "EL REGISTRO ES CONFIDENCIAL Y ANÓNIMO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFFFD94A),
                          fontSize: responsive.diagonalP(1.7),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                        ),
                      ),
                      SizedBox(height: responsive.altoP(0.7)),
                      Text(
                        "Tu identidad esta protegida",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.diagonalP(1.4),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // ===================== CUERPO =====================
                Flexible(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0.08,
                          child: SvgPicture.asset(
                            'assets/img/escudo-policia-b.svg',
                            width: responsive.anchoP(38),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.anchoP(4.2),
                            vertical: responsive.altoP(1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "La Policía Nacional del Ecuador pone a tu disposición este canal seguro para compartir información que permita prevenir o investigar posibles hechos delictivos.\n\n"
                                    "Tu colaboración es tratada con estricta confidencialidad y seguridad, conforme a la Ley Orgánica de Protección de Datos Personales del Ecuador; en ningún caso se revelará tu identidad sin autorización.\n\n"
                                    "Los datos de esta denuncia se usan únicamente con fines institucionales de análisis, verificación y atención, para fortalecer la seguridad ciudadana.\n\n"
                                    "Cualquier información, por mínima que sea, puede prevenir delitos y proteger a otras personas.\n\n"
                                    "Al continuar, autorizas el tratamiento de estos datos y aceptas que usemos la ubicación de tu dispositivo para capturar automáticamente la georreferencia del reporte.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: responsive.diagonalP(1.45),
                                  color: const Color(0xFF20252B),
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ===================== DIVISOR =====================
                Container(
                  height: 1,
                  color: const Color(0xFFE0E5EC),
                ),

                // ===================== BOTONES =====================
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF8FAFD),
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.anchoP(3.5),
                    vertical: responsive.altoP(2.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: responsive.anchoP(18),
                        child: OutlinedButton(
                          onPressed: controller.rechazarDialogoTerminos,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(
                              color: Color(0xFF7B7F86),
                              width: 1.4,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: const Color(0xFF5E636B),
                              fontWeight: FontWeight.w700,
                              fontSize: responsive.diagonalP(1.45),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: responsive.anchoP(1.6)),
                      SizedBox(
                        width: responsive.anchoP(26),
                        child: ElevatedButton(
                          onPressed: controller.aceptarDialogoTerminos,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF0A3D78),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Si, acepto",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: responsive.diagonalP(1.45),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

