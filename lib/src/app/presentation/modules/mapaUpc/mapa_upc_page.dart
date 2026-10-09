part of '../pages.dart';

class MapaUpcPage extends GetView<MapaUpcController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapaUpcController>(
      builder: (_) => getContenido(context),
    );
  }

  Widget getContenido(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Scaffold(
      bottomNavigationBar: bannerInferior(responsive),
      appBar: getAppBar('Encuentra la Upc más cercana'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: responsive.alto,
            child: Stack(
              children: [
                Obx(() => AppConfig.ubicacion.value.latitude != 0.0
                    ? GestureDetector(
                  child: Obx(() => FlutterMap(
                    mapController: controller.mapController,
                    options: MapOptions(
                      initialCenter: AppConfig.ubicacion.value,
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                        minZoom: controller.minZoom,
                        maxZoom: controller.maxZoom,
                        userAgentPackageName: 'policia.ecuador',
                      ),

                      // UBICACIÓN ACTUAL DEL USUARIO
                      MarkerLayer(
                        markers: [
                          AppConfig.ubicacion.value.latitude != 0.0
                              ? markerPersona()
                              : markerPersonaVacio(),
                        ],
                      ),

                      // MARCADORES DE UPC
                      controller.datosUpc.isNotEmpty
                          ? getMarcadores(context)
                          : markerBlanco(context),

                      // ESTADO DE CONEXIÓN
                      ConnectionStatusBanner(
                        status: controller.status,
                        onInit: controller.connectionStatusController,
                      ),

                      // RUTA HACIA LA UPC
                      Obx(() => controller.polylineCoords.isNotEmpty
                          ? PolylineLayer(
                        polylines: [
                          Polyline(
                            points: controller.polylineCoords,
                            strokeWidth: 6,
                            color: const Color(0xFF093483),
                          ),
                        ],
                      )
                          : const SizedBox.shrink()),
                    ],
                  )),
                )
                    : const SizedBox.shrink()),

                Column(
                  children: [
                    SizedBox(height: responsive.altoP(55)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: responsive.anchoP(2)),
                        Column(
                          children: [
                            getBtnMyUbicacion(),
                            getBtnZoom(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Obx(() => CargandoWidget(
                  mostrar: controller.peticionServerState.value,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBtnZoom() {
    return Column(
      children: <Widget>[
        CustomMap.getBtnCustomIcon(
          icon: Icons.zoom_in,
          colorIcon: Colors.blue.shade900,
          colorRelleno: controller.colorBtnRelleno,
          ontap: () {
            final centerZoom = controller.zoomMap;
            final zoom = centerZoom + 1;

            if (zoom <= controller.maxZoom) {
              controller.zoomMap = zoom;
              controller.mapController.move(
                LatLng(
                  AppConfig.ubicacion.value.latitude,
                  AppConfig.ubicacion.value.longitude,
                ),
                controller.zoomMap,
              );
              controller.btnZoomMas = true;
              controller.btnZoomMenos = true;
            }
          },
          size: controller.sizeBtnSobreMapa,
        ),
        CustomMap.getBtnCustomIcon(
          icon: Icons.zoom_out,
          colorIcon: Colors.blue.shade900,
          colorRelleno: controller.colorBtnRelleno,
          ontap: () {
            final centerZoom = controller.zoomMap;
            final zoom = centerZoom - 1;

            if (zoom >= controller.minZoom) {
              controller.zoomMap = zoom;
              controller.mapController.move(
                LatLng(
                  AppConfig.ubicacion.value.latitude,
                  AppConfig.ubicacion.value.longitude,
                ),
                controller.zoomMap,
              );
              controller.btnZoomMenos = true;
              controller.btnZoomMas = true;
            }
          },
          size: controller.sizeBtnSobreMapa,
        ),
      ],
    );
  }

  Widget getBtnMyUbicacion() {
    return Column(
      children: <Widget>[
        CustomMap.getBtnCustomIcon(
          icon: Icons.my_location,
          colorIcon: Colors.blue.shade900,
          colorRelleno: controller.colorBtnRelleno,
          ontap: () {
            controller.polylineCoords.clear();
            controller.consultarUpc();
          },
          size: controller.sizeBtnSobreMapa,
        ),
        CustomMap.getBtnCustomIcon(
          icon: Icons.filter_center_focus,
          colorIcon: Colors.blue.shade900,
          colorRelleno: controller.colorBtnRelleno,
          ontap: () {
            controller.getBount();
          },
          size: controller.sizeBtnSobreMapa,
        ),
      ],
    );
  }

  MarkerLayer markerBlanco(BuildContext context) {
    return const MarkerLayer(markers: []);
  }

  MarkerLayer getMarcadores(BuildContext context) {
    final List<Marker> markers = [];

    for (int i = 0; i < controller.datosUpc.length; i++) {
      final double distancia = double.parse(controller.datosUpc[i].distance) * 1000;

      markers.add(
        Marker(
          width: 70.0,
          height: 70.0,
          point: LatLng(
            double.parse(controller.datosUpc[i].latitudUpc),
            double.parse(controller.datosUpc[i].longitudUpc),
          ),
          child: stiloMarcador(
            nom: controller.datosUpc[i].descripcionUpc,
            valueKey: i.toString(),
            dir: controller.datosUpc[i].dirUpc,
            distancia: '${distancia.toStringAsFixed(2)} mts.',
            long2: controller.datosUpc[i].longitudUpc,
            lat1: AppConfig.ubicacion.value.latitude.toString(),
            lat2: controller.datosUpc[i].latitudUpc,
            long1: AppConfig.ubicacion.value.longitude.toString(),
            telf: controller.datosUpc[i].fonoUpc,
            context: context,
            icon: AppImages.imgMarker_upc,
            mail: controller.datosUpc[i].mailUpc,
          ),
        ),
      );
    }

    return MarkerLayer(markers: markers);
  }

  void getLimpiaMarcadores() {
    controller.datosUpc.clear();
  }

  Widget stiloMarcador({
    required String icon,
    required String valueKey,
    required String nom,
    required String dir,
    required String lat1,
    required String long1,
    required String lat2,
    required String long2,
    required String telf,
    required String distancia,
    required String mail,
    required BuildContext context,
  }) {
    final Key key = ValueKey(valueKey);

    return Container(
      key: key,
      child: IconButton(
        icon: Image.asset(
          icon,
          package: AppConfig.namePackage,
        ),
        color: Colors.blue,
        iconSize: 20.0,
        onPressed: () {
          mostrarInfoWindowPunto(
            long1: long1,
            lat2: lat2,
            lat1: lat1,
            long2: long2,
            context: context,
            nombre: nom,
            dir: dir,
            mail: mail,
            imagen: '',
            telf: telf,
            dist: distancia,
          );
        },
      ),
    );
  }

  void mostrarInfoWindowPunto({
    required BuildContext context,
    required String nombre,
    required String dir,
    required String mail,
    required String imagen,
    required String telf,
    required String dist,
    required String lat1,
    required String long1,
    required String lat2,
    required String long2,
  }) {
    OpcionesUpcWidget.opcionUpc(
      lat1: lat1,
      lat2: lat2,
      long1: long1,
      long2: long2,
      ctxt: context,
      nombreUpc: nombre,
      dir: dir,
      mail: mail,
      telf: telf,
      dist: dist,
      imagen: imagen,
    );
  }

  Marker markerPersonaVacio() {
    return Marker(
      point: LatLng(
        controller.latitudMiUbicacion,
        controller.longitudMiUbicacion,
      ),
      width: 0,
      height: 0,
      child: const SizedBox.shrink(),
    );
  }

  Marker markerPersona() {
    return Marker(
      point: LatLng(
        AppConfig.ubicacion.value.latitude,
        AppConfig.ubicacion.value.longitude,
      ),
      width: 55,
      height: 55,
      child: Image.asset(
        AppImages.imgMarker_persona,
        package: AppConfig.namePackage,
      ),
    );
  }

  AppBar getAppBar(String titleAppBar) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF06245B),
              Colors.grey.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      title: Text(
        titleAppBar,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.white,
              tooltip: 'Atrás',
              onPressed: () => Get.back(),
            ),
          );
        },
      ),
    );
  }

  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey,
            Color(0xFF06245B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Color(0xFF0A2A66),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          socialIconButton(
            iconPath: AppImages.imgFacebook,
            onTap: launchURLFace,
          ),
          socialIconButton(
            iconPath: AppImages.imgTwitter,
            onTap: launchURLTwitter,
          ),
          socialIconButton(
            iconPath: AppImages.imgInstagran,
            onTap: launchURLInsta,
          ),
          socialIconButton(
            iconPath: AppImages.imgYoutube,
            onTap: launchURLYou,
          ),
        ],
      ),
    );
  }

  Widget socialIconButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white30,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          iconPath,
          package: AppConfig.namePackage,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  static Future<void> launchURLFace() async {
    final url = Uri.parse('https://www.facebook.com/policia.ecuador');

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLTwitter() async {
    final url = Uri.parse('https://twitter.com/PoliciaEcuador');

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLInsta() async {
    final url = Uri.parse(
      'https://www.instagram.com/policiaecuadoroficial',
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLYou() async {
    final url = Uri.parse(
      'https://www.youtube.com/user/policiaecuador2',
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}