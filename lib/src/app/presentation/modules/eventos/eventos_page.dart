part of '../pages.dart';

class EventosPage extends GetView<EventosController> {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaItemsPageWidget(
      titleAppBar: controller.nombreModulo,
      peticionServer: controller.peticionServerState,
      contenido: getContenido(),
      foto64: controller.imagenModulo,
      btnAtras: true,
    );

  }

  // ===================== 🧱 CONTENIDO PRINCIPAL =====================
  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ConnectionStatusBanner(
            status: controller.status,                            // 👈 tu Rx<ConnectionStatus>
            onInit: controller.connectionStatusController,        // 👈 opcional
          ),
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: responsive.anchoP(3)),
                    child: getDesingContenido(responsive),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


// ===================== 🧾 CUERPO PRINCIPAL =====================
  Widget getDesingContenido(ResponsiveUtil responsive) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black26,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // 🔹 Combo de eventos
            ComboBusqueda<Catalogo>(
              title: "Evento",
              selectValue: controller.idDelitoSeleccionado.value == 0
                  ? null
                  : controller.listDelito.firstWhereOrNull(
                      (c) => c.idDinCatalogosApp == controller.idDelitoSeleccionado.value),
              datos: controller.listDelito,
              displayField: (item) => item.descripcion,
              searchHint: "Seleccione un evento",
              textSeleccioneUndato: "Seleccione un evento",
              complete: (value) {
                if (value != null) {
                  controller.idDelitoSeleccionado.value = value.idDinCatalogosApp;
                  controller.nombreDelitoSeleccionado.value = value.descripcion;
                  controller.mostrarBtnGuardar(true);
                }
              },
            ),

            const SizedBox(height: 20),
            // 🔹 Observación
            Text(
              'Observación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: responsive.diagonalP(1.9),
                color: const Color(0xFF06245B),
              ),
            ),
            const SizedBox(height: 10),
            ContadorTextArea(
              maxLength: 100,
              controller: controller.descripcionController,
              onChanged: (texto) {},
            ),

            const SizedBox(height: 20),
            // 🖼️ Foto (opcional)
            Obx(() => controller.idDelitoSeleccionado.value != 0
                ? wgFoto(responsive)
                : const SizedBox.shrink()),

            const SizedBox(height: 25),

            // 💾 Botón guardar (solo visible si se selecciona un evento)
            Obx(() => controller.idDelitoSeleccionado.value != 0
                ? btnGuardar()
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

// ===================== 🖼️ FOTO (CON ELIMINAR Y ANIMACIÓN) =====================
  Widget wgFoto(ResponsiveUtil responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: const [
            Icon(Icons.image_outlined, color: Color(0xFF06245B)),
            SizedBox(width: 8),
            Text(
              "Agregar Imagen hhhh(opcional)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF06245B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 🔹 Botón para seleccionar o cambiar imagen
        GestureDetector(
          onTap: () async {
            controller.mGaleryCameraModel.value =
            await PhotoHelper.getDesingPictureGaleryOrCamera(
              initPeticion: (value) => controller.peticionServerState(value),
              titleImg: "foto_${controller.nombreDelitoSeleccionado.value}",
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade100,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_a_photo_rounded,
                    color: Color(0xFF195ba6), size: 20),
                const SizedBox(width: 8),
                Text(
                  controller.mGaleryCameraModel.value == null
                      ? "Agregar Imagen"
                      : "Cambiar Imagen",
                  style: const TextStyle(
                    color: Color(0xFF06245B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 15),

        // 🔹 Imagen seleccionada con efecto AnimatedSwitcher
        Obx(() {
          final imagen = controller.mGaleryCameraModel.value;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: imagen == null
                ? const SizedBox.shrink()
                : Center(
              key: ValueKey(imagen),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // 📸 Imagen mostrada
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      imagen.imageFile,
                      fit: BoxFit.cover,
                      height: responsive.altoP(28),
                      width: responsive.altoP(28),
                    ),
                  ),

                  // ❌ Botón eliminar
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        controller.mGaleryCameraModel.value = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

// ===================== 💾 BOTÓN GUARDAR =====================
  Widget btnGuardar() {
    controller.connectionStatusController();

    return Obx(() {
      final online = controller.status.value == ConnectionStatus.online;
      final delitoSeleccionado = controller.idDelitoSeleccionado.value != 0;

      if (!delitoSeleccionado) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: GestureDetector(
          onTapDown: (_) => controller.btnPressed.value = true,
          onTapUp: (_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            controller.btnPressed.value = false;

            if (online) {
              await controller.guardarEvento(controller.idDelitoSeleccionado.value);

            } else {
              DialogosAwesome.getError(
                descripcion:
                "No tiene conexión a Internet para realizar el registro.",
              );
            }
          },
          onTapCancel: () => controller.btnPressed.value = false,
          child: Obx(() {
            final isPressed = controller.btnPressed.value;

            return AnimatedScale(
              scale: isPressed ? 0.96 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF195BA6),
                      Color(0xFF0A2E5C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isPressed
                          ? Colors.black26.withOpacity(0.1)
                          : Colors.black26.withOpacity(0.3),
                      blurRadius: isPressed ? 4 : 12,
                      offset: Offset(0, isPressed ? 1 : 4),
                    ),
                  ],
                ),
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save_rounded,
                        size: 26, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      "GUARDAR EVENTO",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0.5, 0.8),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }

}
