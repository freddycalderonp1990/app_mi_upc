part of '../pages.dart';

class ServiciosPage extends GetView<ServiciosController> {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaItemsPageWidget(
      titleAppBar: controller.nombreModulo,
      btnAtras: true,
      peticionServer: controller.peticionServerState,
      contenido: getContenido(),
      foto64: controller.imagenModulo,
    );
  }

  /// 📦 Contenido general con scroll y grid
  Widget getContenido() {
    final responsive = ResponsiveUtil();
    return Padding(
      padding: EdgeInsets.only(top: responsive.altoP(1.5)),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 🔹 Estado de conexión
                ConnectionStatusBanner(
                  status: controller.status,
                  onInit: controller.connectionStatusController,
                ),

                // 🔹 Grid de servicios
                SizedBox(
                  child: Obx(() => getGridServicios()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🧩 GRID PRINCIPAL DE SERVICIOS
  Widget getGridServicios() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        // 📋 GRID
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: responsive.anchoP(2),
            vertical: responsive.altoP(1),
          ),
          itemCount: controller.listaServicios?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: responsive.anchoP(8),
            mainAxisSpacing: responsive.altoP(2),
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, ind) {
            final servicio = controller.listaServicios[ind];
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 1.0),
              duration: const Duration(milliseconds: 200),
              builder: (context, scale, child) {
                return GestureDetector(
                  onTapDown: (_) => controller.selectedIndex.value = ind,
                  onTapUp: (_) async {
                    await Future.delayed(const Duration(milliseconds: 80));
                    getDatosServicio(ind);
                  },
                  onTapCancel: () => controller.selectedIndex.value = -1,
                  child: Obx(() {
                    final isSelected = controller.selectedIndex.value == ind;
                    return AnimatedScale(
                      scale: isSelected ? 0.94 : 1.0,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Imagen centrada
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: servicio.imgBase64.isEmpty
                                  ? Image.asset(
                                AppImages.vineta,
                                height: responsive.altoP(9),
                                width: responsive.altoP(9),
                                fit: BoxFit.contain,
                              )
                                  : Image.memory(
                                base64Decode(servicio.imgBase64),
                                height: responsive.altoP(9),
                                width: responsive.altoP(9),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: responsive.altoP(1)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.anchoP(2),
                              ),
                              child: Text(
                                servicio.descripcion.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: responsive.diagonalP(1.3),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF06245B),
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            );
          },
        ),

        // 🔹 Botones finales
        if (controller.id == 3 &&
            controller.menuPrincipalController.listaPermiso.isNotEmpty)
          _botonVerificalaerta(responsive),
        _botonInicioServicio(responsive),
      ],
    );
  }

  /// 🔍 Acción al tocar un servicio
  Future<void> getDatosServicio(int ind) async {
    String resumen = controller.listaServicios[ind].resumen.toString();
    String img = controller.listaServicios[ind].imgBase64;
    int id = controller.listaServicios[ind].idUpcServicio;
    String servicio = controller.listaServicios[ind].descripcion;

    if (controller.status.value == ConnectionStatus.online) {
      await controller.cargarDatosDetalleLista(id);
    } else {
      controller.cargarDatosDetalleListaOffLine(id);
    }

    if (servicio.toUpperCase().trim() == 'CUENTALE A PAQUITO') {
      if (controller.idGenPersona==0) {
        DialogosAwesome.getError(
          descripcion:
          "Para usar esta opción debe registrarse como usuario luego intente nuevamente.",btnOkOnPress: (){Get.back();}
        );
        controller.peticionServerState(false);
        return;
      }
      Map<String, String> data = {
        "id": "1",
        "imagen": img,
        "nombreModulo": 'Registro Evento',
      };
      Get.toNamed(AppRoutes.REGISTRAR_EVENTO, parameters: data);
    } else {
      DialogosAwesome.getAlertDetalleServicios(
        title: servicio.toUpperCase(),
        body: bodyDetlleListaServicios(resumen, servicio),
        imagen: img,
      );
    }
  }

  /// 📜 Detalle del servicio seleccionado
  Widget bodyDetlleListaServicios(String resumen, String servicio) {
    final responsive = ResponsiveUtil();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(responsive.anchoP(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: responsive.altoP(1)),
            Text(
              resumen,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: responsive.diagonalP(1.3),
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
            SizedBox(height: responsive.altoP(1)),
            Text(
              controller.detalle.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: responsive.diagonalP(1.3),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF06245B),
              ),
            ),
            getListaItemsServicios(),
          ],
        ),
      ),
    );
  }

  Widget getListaItemsServicios() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.listaItemsServicios.length,
          itemBuilder: (context, ind) {
            final item = controller.listaItemsServicios[ind];
            return Padding(
              padding: EdgeInsets.only(bottom: responsive.altoP(1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    size: responsive.diagonalP(0.8),
                    color: Colors.blueGrey[400],
                  ),
                  SizedBox(width: responsive.anchoP(2)),
                  Expanded(
                    child: Text(
                      item.descripcion,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: responsive.diagonalP(1.2),
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ],
    );
  }
  Widget _botonVerificalaerta(ResponsiveUtil responsive) {
    final RxBool presionado = false.obs;
    return Padding(
      padding: EdgeInsets.only(
        top: responsive.altoP(2),
        bottom: responsive.altoP(3),
      ),
      child: Column(
        children: [
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.8,
            indent: responsive.anchoP(5),
            endIndent: responsive.anchoP(5),
          ),
          SizedBox(height: responsive.altoP(1.2)),

          // ✅ Solo se usa Obx si hay una variable reactiva (presionado)
          Obx(() => GestureDetector(
            onTapDown: (_) => presionado.value = true,
            onTapUp: (_) => presionado.value = false,
            onTapCancel: () => presionado.value = false,
            onTap: () => Get.toNamed(AppRoutes.DETALLEALERTAS),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 120),
              scale: presionado.value ? 0.97 : 1.0,
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: responsive.anchoP(85),
                height: responsive.altoP(9.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          presionado.value ? 0.05 : 0.12),
                      blurRadius: presionado.value ? 3 : 8,
                      offset: Offset(0, presionado.value ? 2 : 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF195BA6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(responsive.anchoP(2)),
                      child: Image.asset(
                        AppImages.imgVerificaAlerta,
                        height: responsive.altoP(5),
                        width: responsive.altoP(5),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: responsive.anchoP(2)),
                    Flexible(
                      child: Text(
                        "VERIFICAR ALERTA",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: responsive.diagonalP(1.45),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF06245B),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
  Widget _botonInicioServicio(ResponsiveUtil responsive) {
    // ⚙️ Solo usamos Obx si hay variables Rx dentro
    final mostrar = (controller.id == 3 &&
        controller.menuPrincipalController.listaPermiso.isNotEmpty &&
        controller.menuPrincipalController.listaPermiso[0].servicio == 'N' &&
        AppConfig.servicio.value == false);

    // Si no debe mostrarse, devolvemos vacío SIN Obx
    if (!mostrar) return const SizedBox.shrink();

    return Obx(() {
      final presionado = controller.pulsado.value;

      return Padding(
        padding: EdgeInsets.only(
          top: responsive.altoP(2),
          bottom: responsive.altoP(3),
        ),
        child: GestureDetector(
          onTap: () {
            DialogosAwesome.getWarningSiNo(
              descripcion:
              "¿Está seguro de iniciar el servicio?\nUna vez iniciado no podrá cancelarlo.",
              btnOkOnPress: () {
                Get.back();
                controller.inicioServicioUsuario();
              },
            );
          },
          onTapDown: (_) => controller.pulsado.value = true,
          onTapUp: (_) => controller.pulsado.value = false,
          onTapCancel: () => controller.pulsado.value = false,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            transform: Matrix4.identity()..scale(presionado ? 0.97 : 1.0),
            curve: Curves.easeOut,
            width: responsive.anchoP(85),
            height: responsive.altoP(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: presionado
                    ? [const Color(0xFF1E4C8C), const Color(0xFF06245B)]
                    : [const Color(0xFF06245B), const Color(0xFF1E4C8C)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(presionado ? 0.12 : 0.25),
                  blurRadius: presionado ? 5 : 10,
                  offset: Offset(0, presionado ? 2 : 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(responsive.anchoP(2)),
                  child: Image.asset(
                    AppImages.imgIniciaServicio,
                    height: responsive.altoP(5),
                    width: responsive.altoP(5),
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: responsive.anchoP(3)),
                Flexible(
                  child: Text(
                    "INICIAR SERVICIO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: responsive.diagonalP(1.45),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

}
