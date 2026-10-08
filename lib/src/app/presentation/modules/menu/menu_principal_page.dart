part of '../pages.dart';
class MenuPrincipalPage extends GetView<MenuPrincipalController> {
  const MenuPrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        WorkAreaMenuPageWidget(
          btnAtras: false,
          pantallaIrAtras: () => Get.back(),
          peticionServer: controller.peticionServerState,
          numNotificacion: controller.listaAlertasUsuario.length.obs,
          contenido:
          controller.status.value == ConnectionStatus.online
              ? getContenido()
              : getContenido(),
          mostrarNotificacion: controller.listaPermiso.length > 0,
        ));
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Column(
      children: [
        SizedBox(height: responsive.altoP(0.50)),
        getCabeceraPremium(responsive),
        SizedBox(height: responsive.altoP(1.0)),

        Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: responsive.altoP(1.2)),
                  Expanded(
                    child: SizedBox(
                      width: responsive.anchoP(88),
                      child: getListaDatosModulos(),
                    ),
                  ),
                ],
              ),
              ConnectionStatusBanner(
                status: controller.status,
                onInit: controller.connectionStatusController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getListaDatosModulos() {
    final responsive = ResponsiveUtil();

    return Obx(() {
      final mods = controller.listaModulo;

      if (mods.isEmpty) {
        return const Center(
          child: Text(
            'No existen módulos disponibles',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        );
      }

      final bool modoHorizontal = mods.length <= 2;

      return GridView.builder(
        padding: EdgeInsets.fromLTRB(
          responsive.anchoP(1),
          responsive.altoP(0.6),
          responsive.anchoP(1),
          responsive.altoP(2.6),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: modoHorizontal ? 1 : 2,
          crossAxisSpacing: responsive.anchoP(4),
          mainAxisSpacing: responsive.altoP(2),
          childAspectRatio: modoHorizontal ? 2.95 : 0.95,
        ),
        itemCount: mods.length,
        itemBuilder: (context, i) {
          final m = mods[i];

          return ModuleCard(
            title: m.tituloModulo,
            base64Img: m.imgBase64.isEmpty ? null : m.imgBase64,
            destacado: i == 0,
            onTap: () => muestraPantalla(i, context),
          );
        },
      );
    });
  }

  Widget getCabeceraPremium(ResponsiveUtil responsive) {
    final bytes = controller.fotoPerfilBytes.value;
    final userName = controller.userPref.value.trim();
    final metodo = controller.metodoRegistro.value.trim();
    final saludo = controller.obtenerSaludo();
    final correo = controller.correoUsuario.value.trim();
    final telefono = controller.telefonoUsuario.value.trim();

    final metodoUi = controller.getMetodoAuthUI(metodo);
    final IconData iconoMetodo = metodoUi['icono'];
    final String tituloMetodo = metodoUi['titulo'];
    final Color colorMetodo = metodoUi['color'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B2E59),
            Color(0xFF195BA6),
            Color(0xFF6C7B8B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF195BA6).withOpacity(0.20),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAvatarPremium(responsive, bytes),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white24,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              saludo,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: responsive.diagonalP(1.3),
                                color: Colors.white.withOpacity(0.92),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userName.isNotEmpty ? userName : 'Usuario',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: responsive.diagonalP(1.6),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.08,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: _buildResumenAuthCard(
                  responsive: responsive,
                  iconoMetodo: iconoMetodo,
                  tituloMetodo: tituloMetodo,
                  colorMetodo: colorMetodo,
                  correo: correo,
                  telefono: telefono,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Hoy ${UtilidadesUtil.getFechaActual}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: responsive.diagonalP(1.2),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(
                      'Seguro',
                      style: TextStyle(
                        fontSize: responsive.diagonalP(0.72),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPremium(ResponsiveUtil responsive, Uint8List? bytes) {
    final size = responsive.altoP(8);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF195BA6).withOpacity(0.65),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                    child: bytes == null
                        ? Icon(
                      Icons.person_rounded,
                      size: responsive.altoP(3.7),
                      color: Colors.blueGrey.shade400,
                    )
                        : null,
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF35C759),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResumenAuthCard({
    required ResponsiveUtil responsive,
    required IconData iconoMetodo,
    required String tituloMetodo,
    required Color colorMetodo,
    required String correo,
    required String telefono,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white24,
          width: 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorMetodo.withOpacity(0.22),
                  border: Border.all(
                    color: colorMetodo.withOpacity(0.45),
                    width: 0.8,
                  ),
                ),
                child: Icon(
                  iconoMetodo,
                  size: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tituloMetodo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: responsive.diagonalP(0.9),
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildResumenDato(
            responsive: responsive,
            icono: Icons.email_outlined,
            texto: correo.isNotEmpty ? correo : 'Sin correo registrado',
          ),
          const SizedBox(height: 7),
          _buildResumenDato(
            responsive: responsive,
            icono: Icons.phone_iphone_rounded,
            texto: telefono.isNotEmpty ? telefono : 'Sin teléfono',
          ),
        ],
      ),
    );
  }
  Widget _buildResumenDato({
    required ResponsiveUtil responsive,
    required IconData icono,
    required String texto,
  }) {
    return Row(
      children: [
        Container(
          width: 20,
          alignment: Alignment.centerLeft,
          child: Icon(
            icono,
            size: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            texto,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: responsive.diagonalP(0.9),
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
  muestraPantalla(index, BuildContext ctx) async {

    if (controller.listaModulo[0].tituloModulo=='ENCUENTRA LA UPC MÁS CERCANA') {
      if (index == 0) {
        if (controller.status == ConnectionStatus.online) {
          controller.verificarGps();
        } else {
          DialogosAwesome.getError(descripcion: "No tiene Conexión a Internet");
        }
      }
      if (index == 1) {
        if (controller.status == ConnectionStatus.online) {
          Map<String, String> data = {
            "id": "3",
            "imagen": controller.listaModulo[1].imgBase64,
            "nombreModulo": 'Violencia de Género',
          };
          Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
        } else {
          DialogosAwesome.getError(
            descripcion: "No tiene Conexión a Internet para registrar un evento",
          );
        }
      }

      if (index == 2) {
        Map<String, String> data = {
          "id": "1",
          "imagen": controller.listaModulo[2].imgBase64,
          "nombreModulo": 'Servicio Policía Comunitaria',
        };
        Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
      }
      if (index == 3) {
        Map<String, String> data = {
          "id": "2",
          "imagen": controller.listaModulo[3].imgBase64,
          "nombreModulo": 'Medidas de Autoprotección',
        };
        Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
      }

    }else{
      if (index == 1) {
        if (controller.status == ConnectionStatus.online) {
          controller.verificarGps();
        } else {
          DialogosAwesome.getError(descripcion: "No tiene Conexión a Internet");
        }
      }
      if (index == 0) {
        if (controller.status == ConnectionStatus.online) {
          Map<String, String> data = {
            "id": "4",
            "imagen": controller.listaModulo[0].imgBase64,
            "nombreModulo": controller.listaModulo[0].tituloModulo,
          };
          Get.toNamed(AppRoutes.ALERTASDELITOS, parameters: data);

        } else {
          DialogosAwesome.getError(
            descripcion: "No tiene Conexión a Internet para registrar un evento",
          );
        }
      }
      if (index == 2) {
        if (controller.status == ConnectionStatus.online) {
          Map<String, String> data = {
            "id": "3",
            "imagen": controller.listaModulo[2].imgBase64,
            "nombreModulo": 'Violencia de Género',
          };
          Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
        } else {
          DialogosAwesome.getError(
            descripcion: "No tiene Conexión a Internet para registrar un evento",
          );
        }
      }

      if (index == 3) {
        Map<String, String> data = {
          "id": "1",
          "imagen": controller.listaModulo[3].imgBase64,
          "nombreModulo": 'Servicio Policía Comunitaria',
        };
        Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
      }
      if (index == 4) {
        Map<String, String> data = {
          "id": "2",
          "imagen": controller.listaModulo[4].imgBase64,
          "nombreModulo": 'Medidas de Autoprotección',
        };
        Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
      }
    }
  }

  /*muestraPantalla1(index, BuildContext ctx) async {
    if (index == 1) {
      if (controller.status == ConnectionStatus.online) {
        controller.verificarGps();
      } else {
        DialogosAwesome.getError(descripcion: "No tiene Conexión a Internet");
      }
    }
    if (index == 0) {
      if (controller.status == ConnectionStatus.online) {
        Map<String, String> data = {
          "id": "4",
          "imagen": controller.listaModulo[0].imgBase64,
          "nombreModulo": controller.listaModulo[0].descripcionModulo,
        };
        Get.toNamed(AppRoutes.ALERTASDELITOS, parameters: data);

      } else {
        DialogosAwesome.getError(
          descripcion: "No tiene Conexión a Internet para registrar un evento",
        );
      }
    }
    /*if (index == 0) {
      if (controller.status == ConnectionStatus.online) {

        if (controller.tienePermisoAlerta.value){
          Map<String, String> data = {
            "id": "4",
            "imagen": controller.listaModulo[0].imgBase64,
            "nombreModulo": 'Alertas 1800-DELITO',
          };
          Get.toNamed(AppRoutes.ALERTASDELITOS, parameters: data);
        }else{
          Map<String, String> data = {
            "id": "3",
            "imagen": controller.listaModulo[1].imgBase64,
            "nombreModulo": 'Violencia de Género',
          };
          Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
        }

      } else {
        DialogosAwesome.getError(
          descripcion: "No tiene Conexión a Internet para registrar un evento",
        );
      }
    }*/
    if (index == 2) {
      if (controller.status == ConnectionStatus.online) {
        Map<String, String> data = {
          "id": "3",
          "imagen": controller.listaModulo[2].imgBase64,
          "nombreModulo": 'Violencia de Género',
        };
        Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
      } else {
        DialogosAwesome.getError(
          descripcion: "No tiene Conexión a Internet para registrar un evento",
        );
      }
    }

    if (index == 3) {
      Map<String, String> data = {
        "id": "1",
        "imagen": controller.listaModulo[3].imgBase64,
        "nombreModulo": 'Servicio Policía Comunitaria',
      };
      Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
    }
    if (index == 4) {
      Map<String, String> data = {
        "id": "2",
        "imagen": controller.listaModulo[4].imgBase64,
        "nombreModulo": 'Medidas de Autoprotección',
      };
      Get.toNamed(AppRoutes.SERVICIOS, parameters: data);
    }
  }*/
}
