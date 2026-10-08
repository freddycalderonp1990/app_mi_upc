part of '../pages.dart';

class VehiculosPage extends GetView<VehiculosController> {
  const VehiculosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaItemsPageWidget(
      titleAppBar: 'Alerta Vehículos Robodos',
      btnAtras: false,
      peticionServer: controller.peticionServerState,
      contenido: getContenido(),
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                getCabecera(responsive),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.anchoP(2),
                  ),
                  child: getDesingContenido(responsive),
                ),
              ],
            ),
            warningWidgetGetX(),
          ],
        ),
      ],
    );
  }

  Widget warningWidgetGetX() {
    controller.connectionStatusController();
    return Obx(() {
      final online = controller.status.value == ConnectionStatus.online;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: online ? 0 : 40,
        child:
            online
                ? const SizedBox.shrink()
                : Container(
                  width: double.infinity,
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Sin conexión a Internet',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
      );
    });
  }

  Widget getCabecera(ResponsiveUtil responsive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.grey,Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar circular
            CircleAvatar(
              radius: responsive.altoP(4.5),
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: ImagenBase64Widget(
                  base64String: controller.imagenModulo,
                  height: responsive.altoP(9),
                  isCircular: false,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Texto de fecha
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fecha del evento:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      controller.fecha,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDesingContenido(ResponsiveUtil responsive) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === BUSCADOR POR PLACA ===
                  Text(
                    'Placa Vehículo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.diagonalP(1.9),
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.placaController,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Ej: PBA1234',
                            labelText: 'Placa',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.directions_car_filled),
                          ),
                          onChanged: (v) {
                            controller.limpiarDatosVehiculo(); // si editan la placa, resetea campos
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),

                  // Barra de progreso visible mientras busca
                  Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: controller.cargandoConsulta.value ? 8 : 0,
                    margin: const EdgeInsets.only(top: 12),
                    child: controller.cargandoConsulta.value
                        ? const LinearProgressIndicator(minHeight: 8)
                        : const SizedBox.shrink(),
                  )),

                  const SizedBox(height: 20),
                  const Divider(),

                  // === CAMPOS EDITABLES (se muestran después de una consulta, haya o no resultado) ===
                  Obx(() {
                    final mostrarCampos = controller.consultaRealizada.value || controller.vehiculoEncontrado.value;
                    if (mostrarCampos) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Datos del vehículo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.diagonalP(1.9),
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _campoTexto(
                          label: 'Marca',
                          controller: controller.marcaController,
                          hint: 'Ej: CHEVROLET',
                          textCapitalization: TextCapitalization.characters,
                          icon: Icons.directions_car,
                        ),
                        const SizedBox(height: 10),
                        _campoTexto(
                          label: 'Color',
                          controller: controller.colorController,
                          hint: 'Ej: PLATA',
                          textCapitalization: TextCapitalization.characters,
                          icon: Icons.palette_outlined,
                        ),
                        const SizedBox(height: 10),
                        _campoTexto(
                          label: 'Año de fabricación',
                          controller: controller.anioController,
                          hint: 'Ej: 2020',
                          icon: Icons.event,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 10),

                  // === FOTO OPCIONAL ===
                  wgFoto(responsive),
                  const SizedBox(height: 10),
                  // === BOTÓN GUARDAR ===
                  btnGuardarVehiculo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// TextField estilizado reutilizable
  Widget _campoTexto({
    required String label,
    required TextEditingController controller,
    String? hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }



  Widget btnGuardarVehiculo() {
    controller.connectionStatusController();
    return Obx(() {
      final online = controller.status.value == ConnectionStatus.online;
      final puedeGuardar = controller.vehiculoEncontrado.value &&
          controller.placaController.text.trim().isNotEmpty;

      if (puedeGuardar) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton.icon(
          onPressed: () async {
            if (!online) {
              DialogosAwesome.getError(
                descripcion: "No tiene Internet para realizar el registro",
              );
              return;
            }
            await controller.guardarRegistroVehiculo();
          },
          icon: const Icon(Icons.save_alt_rounded, size: 24),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              "Guardar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 8,
            shadowColor: Colors.black26,
          ),
        ),
      );
    });
  }

  Widget wgFoto(ResponsiveUtil responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TituloTextWidget(title: "Foto (opcional)"),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            controller.mGaleryCameraModel.value =
            await PhotoHelper.getDesingPictureGaleryOrCamera(
              initPeticion: (value) => controller.peticionServerState(value),
              titleImg: "vehiculo_${controller.placaController.text.trim()}",
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.grey.shade100,
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.add_a_photo, color: Colors.blue[900]),
                const SizedBox(width: 10),
                Text(
                  controller.mGaleryCameraModel.value == null
                      ? "Adjuntar una imagen"
                      : "Cambiar la imagen",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Obx(
              () => controller.mGaleryCameraModel.value == null
              ? const SizedBox.shrink()
              : Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                controller.mGaleryCameraModel.value!.imageFile,
                fit: BoxFit.cover,
                height: responsive.altoP(34.0),
                width: responsive.altoP(34.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
