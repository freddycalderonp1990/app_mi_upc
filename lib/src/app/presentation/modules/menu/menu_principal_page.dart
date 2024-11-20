part of '../pages.dart';

class MenuPrincipalPage extends GetView<MenuPrincipalController> {
  const MenuPrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkAreaMenuPageWidget(
      btnAtras: false,
      pantallaIrAtras: () => Get.back(),
      peticionServer: controller.peticionServerState,
      contenido: Obx(() => controller.status.value == ConnectionStatus.online
          ? getContenido()
          : getContenidoSinInternet()),
    );
  }

  getContenido() {
    final responsive = ResponsiveUtil();
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.imgFondo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            getCabecera(responsive),
            SizedBox(
              width: responsive.anchoP(88),
              height: responsive.altoP(65),
              child: Obx(() => getListaDatosModulos()),
            ),
          ],
        ),
        warningWidgetGetX(),
      ],
    );
  }

  warningWidgetGetX() {
    controller.connectionStatusController();
    return Obx(() {
      return Visibility(
          visible: controller.status.value != ConnectionStatus.online,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 70,
                color: Colors.red,
                child: const Row(
                  children: [
                    Icon(Icons.wifi_off),
                    SizedBox(width: 10),
                    Text(
                      'No tiene Conexión a Internet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ));
    });
  }

  getListaDatosModulos() {
    final responsive = ResponsiveUtil();
    Widget listaU = ListView.builder(
      shrinkWrap: true,
      itemCount:
          controller.listaModulo != null ? controller.listaModulo.length : 0,
      itemBuilder: (context, ind) {
        if(ind==0){
          return SizedBox(height: 20,);
        }
        return Obx(() => InkWell(
              onTap: () => {muestraPantalla(ind, context)},
              child: Column(
                children: [
                  SizedBox(
                    width: responsive.anchoP(90),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: responsive.anchoP(2.0),
                            ),
                            imgPerfilRedonda(
                              size: 18,
                              img: controller.listaModulo[ind].imgBase64 == ''
                                  ? null
                                  : controller.listaModulo[ind].imgBase64,
                            ),
                            SizedBox(
                              width: responsive.anchoP(4),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: responsive.anchoP(50),
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    controller.listaModulo[ind].tituloModulo
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: responsive.diagonalP(1.5),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          color: AppConfig.colorBarras,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
    return listaU;
  }

  getCabecera(ResponsiveUtil responsive) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Image.asset(AppImages.imgCabecera_menu_principal),
                  width: responsive.altoP(40),
                ),
              ),
              Container(
                color: Colors.blue[900],
                child: Column(
                  children: <Widget>[
                    const Divider(
                      color: Colors.transparent,
                      height: 5.0,
                    ),
                    Obx(() => controller.userPref != ''
                        ? Text(
                            'BIENVENID@ ${controller.userPref.value}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.diagonalP(1.3),
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'BIENVENID@ ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.diagonalP(1.5),
                              color: Colors.white,
                            ),
                          )),
                    const Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        'Hoy es ${UtilidadesUtil.getFechaActual}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: AppConfig.colorBarras,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  muestraPantalla(index, BuildContext ctx) async {
    if (index == 0) {
      controller.verificarGps();
    }

    if (index == 1) {
      llamarEcu(ctx);
    }
    if (index == 2) {
      Map<String, String> data = {
        "id": "3",
      };
      //violencia
      Get.toNamed(AppRoutesMiUpc.SERVICIOS, parameters: data);
      String _ip = await UtilidadesUtil.getNetworkInfo();
      /* Auditoria auditoria = new Auditoria();
      auditoria.grabaAccion(ConstApi.latitud, ConstApi.longitud, 'COUSULTA',
          'OPCIONES VIOLENCIA DE GÉNERO', prefs.getIdUsuario(), _ip, context);
      Navigator.pushNamed(context, AppConfig.listaViolenciaPage);*/
    }
    if (index == 3) {
      Map<String, String> data = {
        "id": "1",
      };
      //vehiculos
      Get.toNamed(AppRoutesMiUpc.SERVICIOS, parameters: data);
      String _ip = await UtilidadesUtil.getNetworkInfo();
    }
    if (index == 4) {
      Map<String, String> data = {
        "id": "2",
      };
      Get.toNamed(AppRoutesMiUpc.SERVICIOS, parameters: data);
      //AlertasWidget.alertaBannerCovid(ctxt: ctx);
      // Navigator.pushNamed(context, AppConfig.PhotoPreviewScreen);
    }
    if (index == 6) {
      //servicios

      String _ip = await UtilidadesUtil.getNetworkInfo();
      /* Auditoria auditoria = new Auditoria();
      auditoria.grabaAccion(ConstApi.latitud, ConstApi.longitud, 'COUSULTA',
          'LISTA SERVICIOS POLCO', prefs.getIdUsuario(), _ip, context);
      Navigator.pushNamed(context, AppConfig.listaServiciosPolcoPage);*/
    }
    if (index == 7) {
      //tips

      String _ip = await UtilidadesUtil.getNetworkInfo();
      /*Auditoria auditoria = new Auditoria();
      auditoria.grabaAccion(ConstApi.latitud, ConstApi.longitud, 'COUSULTA',
          'MEDIDAS DE AUTOPROTECCIÓN', prefs.getIdUsuario(), _ip, context);
      Navigator.pushNamed(context, AppConfig.listaMedidasAutoproteccionPage);*/
    }

    if (index == 8) {
      // registreToken();
      //noticias

      String _ip = await UtilidadesUtil.getNetworkInfo();
      /*  Auditoria auditoria = new Auditoria();
      auditoria.grabaAccion(ConstApi.latitud, ConstApi.longitud, 'ACCESO',
          'NOTICIAS', prefs.getIdUsuario(), _ip, context);
      Navigator.pushNamed(context, AppConfig.ListaNoticiasPage,
          arguments: '8888888888888888888881');*/
    }

    if (index == 66) {
      //desaparecidos

      String _ip = await UtilidadesUtil.getNetworkInfo();
      /*   Auditoria auditoria = new Auditoria();
      auditoria.grabaAccion(ConstApi.latitud, ConstApi.longitud, 'ACCESO',
          'OPCIONES ALERTA DESAPARECIDOS', prefs.getIdUsuario(), _ip, context);
      Navigator.pushNamed(context, AppConfig.OpcionesAlertaDesaparecidos,
          arguments: '8888888888888888888881');*/
    }
  }

  static void llamarEcu(BuildContext ctx) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '911',
    );
    await launchUrl(launchUri);
  }

  getContenidoSinInternet() {
    final responsive = ResponsiveUtil();
    return Stack(
      children: [
        Column(
          children: [
            getCabecera(responsive),
            SizedBox(
              height: responsive.altoP(15),
            ),
            Container(
              height: responsive.altoP(25),
              child: Image.asset(AppImages.imgNoWifi),
            ),
            SizedBox(
              height: responsive.altoP(5),
            ),
            const Text(
              'No tiene Conexión a Internet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: responsive.altoP(2),
            ),
          ],
        ),
      ],
    );
  }

  Widget btnR() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        SizedBox(
          height: responsive.altoP(5),
        ),
        Container(
          height: responsive.altoP(25),
          child: Image.asset(AppImages.imgSiWifi),
        ),
        SizedBox(
          height: responsive.altoP(5),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50),
          child: Text(
            'La Conexión a Internet esta restablecida favor Cargue los Módulos de Mi Upc',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: responsive.altoP(2),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50),
          width: double.infinity,
          child: MaterialButton(
            elevation: 1.0,
            onPressed: () => controller.cargarDatosLista(),
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.blueGrey[100],
            child: Text(
              'Consultar Módulos',
              style: TextStyle(
                color: AppConfig.colorBarras,
                letterSpacing: 1.5,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        )
      ],
    );
  }
}
