part of '../pages.dart';

class DetalleAlertasPage extends GetView<DetalleAlertasController> {
  const DetalleAlertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaItemsPageWidget(
      titleAppBar: 'Lista de Alertas del Usuario',
      btnAtras: true,
      peticionServer: controller.peticionServerState,
      contenido: getContenido(),
      foto64: "",
    );
  }

  /// ===================== 🧩 CONTENIDO PRINCIPAL =====================
  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Obx(() {
      final listaAlertas = controller.menuPrincipalController.listaAlertasUsuario;

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.anchoP(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Estado de conexión
              ConnectionStatusBanner(
                status: controller.status,
                onInit: controller.connectionStatusController,
              ),
              const SizedBox(height: 12),

              // 🔹 Lista de alertas con contador
              Column(
                children: List.generate(
                  listaAlertas.length,
                      (index) => _cardAlerta(
                    listaAlertas[index],
                    responsive,
                    index, // ← aquí pasamos el contador
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 🔹 Mensaje si no hay alertas
              if (listaAlertas.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: responsive.altoP(4)),
                  child: Text(
                    "No existen alertas registradas para este usuario.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: responsive.diagonalP(1.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  /// ===================== 🧱 CARD DE ALERTA =====================
  Widget _cardAlerta(ListaAlerta alerta, ResponsiveUtil responsive, int index) {
    final foto = (alerta.imgBase64 != null && alerta.imgBase64.toString().isNotEmpty)
        ? Image.memory(base64Decode(alerta.imgBase64), fit: BoxFit.contain)
        : Image.asset(AppImages.noimagen, fit: BoxFit.contain);

    final bool esActiva = alerta.estadoAlerta.toUpperCase().contains("GENERADA");
    final Color estadoColor = esActiva ? const Color(0xFF28A745) : const Color(0xFF6C757D);

    return GestureDetector(
      onTap: () => _mostrarDialogoDetalleAlerta(alerta, responsive),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFDFDFE), Color(0xFFF5F7FB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: estadoColor.withOpacity(0.4), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Contador lateral elegante
            Container(
              width: 45,
              decoration: BoxDecoration(
                color: estadoColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontSize: responsive.diagonalP(1.8),
                    fontWeight: FontWeight.bold,
                    color: estadoColor,
                  ),
                ),
              ),
            ),

            // 🔹 Contenido principal
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔸 Imagen superior con cinta de estado
                    Stack(
                      children: [
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: foto,
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: estadoColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              alerta.estadoAlerta.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 🔸 Cuerpo informativo
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título con ícono
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                  color: estadoColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  color: estadoColor,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  alerta.tipoAlerta.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: responsive.diagonalP(1.7),
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF06245B),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Descripción
                          Text(
                            alerta.observacion.isEmpty
                                ? "Sin observaciones"
                                : alerta.observacion,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: responsive.diagonalP(1.4),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Fecha
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  alerta.fechaRegistroAlerta,
                                  style: TextStyle(
                                    fontSize: responsive.diagonalP(1.2),
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Reportante
                          Row(
                            children: [
                              const Icon(Icons.person_pin_circle_rounded,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "Reporta: ${alerta.reporta}",
                                  style: TextStyle(
                                    fontSize: responsive.diagonalP(1.3),
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
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

  Future<void> _mostrarMapaDistancia(ListaAlerta alerta) async {
    final lat = alerta.latitud;
    final lon = alerta.longitud;

    if (lat == 0 || lon == 0) {
      DialogosAwesome.getInformation(
        descripcion: "No se encontró ubicación geográfica para esta alerta.",
      );
      return;
    }

    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lon&travelmode=driving';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      DialogosAwesome.getError(descripcion: "No se pudo abrir el mapa.");
    }
  }
  Future<void> _llamarNumero(ListaAlerta alerta) async {
    final telefono =controller.telefonoUsuario.isNotEmpty
        ? controller.telefonoUsuario
        : "911"; // fallback institucional

    final Uri url = Uri(scheme: 'tel', path: telefono);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      DialogosAwesome.getError(
        descripcion: "No se pudo iniciar la llamada.",
      );
    }
  }
  void _mostrarDialogoDetalleAlerta(ListaAlerta alerta, ResponsiveUtil responsive) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Encabezado
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: const Color(0xFF195BA6), size: 30),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        alerta.tipoAlerta.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06245B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 🔹 Detalles
                _datoItem("📅 Fecha:", alerta.fechaRegistroAlerta),
                _datoItem("👤 Reporta:", alerta.reporta),
                if (alerta.observacion.isNotEmpty)
                  _datoItem("📝 Observación:", alerta.observacion),

                const SizedBox(height: 20),
                const Divider(thickness: 0.8),

                // 🔹 Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 🗺️ Ver Mapa
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF195BA6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _mostrarMapaDistancia(alerta);
                      },
                      icon: const Icon(Icons.map_outlined, color: Colors.white),
                      label: const Text(
                        "Ver Mapa",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // ☎️ Llamar
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _llamarNumero(alerta);
                      },
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text(
                        "Llamar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ✅ Nuevo botón VALIDAR ALERTA
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      minimumSize: const Size(180, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      mostrarDialogoValidarAlerta(context, alerta.idDinAlertaApp);
                    },
                    icon: const Icon(Icons.verified_rounded, color: Colors.white),
                    label: const Text(
                      "VALIDAR ALERTA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Widget helper para mostrar pares clave-valor
  Widget _datoItem(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          children: [
            TextSpan(
                text: "$titulo ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: valor),
          ],
        ),
      ),
    );
  }

  void mostrarDialogoValidarAlerta(BuildContext context, int idAlerta) {
    final TextEditingController observacionController = TextEditingController();
    final RxString estadoSeleccionado = 'PENDIENTE'.obs;
    final RxInt idCatalogoSeleccionado = 0.obs;

    // 🔹 Cargar catálogo si no está cargado
    if (controller.listaCatalogo.isEmpty) controller.consultaDatosCatalogoAlerta();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        final responsive = MediaQuery.of(context).size;

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Cabecera visual
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF195BA6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.verified_rounded,
                            color: Color(0xFF195BA6), size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Validar Alerta",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF06245B),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close_rounded, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: Colors.black12),
                  const SizedBox(height: 16),

                  // 🔹 Combo de catálogo
                  Obx(() => DropdownButtonFormField<int>(
                    value: idCatalogoSeleccionado.value == 0
                        ? null
                        : idCatalogoSeleccionado.value,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: "Motivo / Justificación",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.list_alt_rounded,
                          color: Color(0xFF195BA6)),
                    ),
                    items: controller.listaCatalogo
                        .map((c) => DropdownMenuItem<int>(
                      value: c.idDinCatalogosApp,
                      child: Text(c.descripcion,
                          overflow: TextOverflow.ellipsis),
                    ))
                        .toList(),
                    onChanged: (val) =>
                    idCatalogoSeleccionado.value = val ?? 0,
                  )),
                  const SizedBox(height: 14),

                  // 🔹 Combo de estado
                  Obx(() => DropdownButtonFormField<String>(
                    value: estadoSeleccionado.value,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: "Estado de la alerta",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.flag_rounded,
                          color: Color(0xFF195BA6)),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: "PENDIENTE", child: Text("PENDIENTE")),
                      DropdownMenuItem(
                          value: "ATENDIDA", child: Text("ATENDIDA")),
                    ],
                    onChanged: (val) =>
                    estadoSeleccionado.value = val ?? "PENDIENTE",
                  )),
                  const SizedBox(height: 14),

                  // 🔹 Campo observación
                  TextFormField(
                    controller: observacionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Observación",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.edit_note_rounded,
                          color: Color(0xFF195BA6)),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 🔹 Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
                        label: const Text("Cancelar",
                            style: TextStyle(color: Colors.grey)),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF195BA6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          if (idCatalogoSeleccionado.value == 0) {
                            DialogosAwesome.getWarning(
                                descripcion: "Seleccione una justificación.");
                            return;
                          }
                          if (observacionController.text.trim().isEmpty) {
                            DialogosAwesome.getWarning(
                                descripcion: "Ingrese una observación.");
                            return;
                          }

                          DialogosAwesome.getWarningSiNo(
                            descripcion:
                            "¿Está seguro de validar esta alerta?",
                            btnOkOnPress: () async {
                              Get.back(); // cerrar confirmación
                              DialogosAwesome.getLoading(
                                  descripcion: "Validando alerta...");
                              await controller.validarAlerta(
                                idAlerta,
                                idCatalogoSeleccionado.value,
                                estadoSeleccionado.value,
                                observacionController.text.trim(),
                              );
                              Get.back(); // cerrar loading
                              Get.back(); // cerrar diálogo principal
                              Get.back();
                              // 🔄 Actualizar lista principal luego de validar
                              await controller.consultaAlertasUsuario();
                            },
                          );
                        },
                        icon: const Icon(Icons.save_alt_rounded,
                            color: Colors.white),
                        label: const Text(
                          "Guardar",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
