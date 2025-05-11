part of 'custom_widgets.dart';

class OpcionesUpcWidget {
  static Future opcionUpc({
    required BuildContext ctxt,
    required String nombreUpc,
    required String dir,
    required String mail,
    required String dist,
    required String telf,
    required String lat1,
    required String long1,
    required String lat2,
    required String long2,
    required String imagen,
  }) {
    final responsive = ResponsiveUtil();
    return showDialog(
        context: ctxt,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.white,
            title: Stack(
              children: <Widget>[
                Center(
                    child: Column(
                  children: [
                    getCabecera(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Color(0xFF06245B),
                      height: 2.0,
                    ),
                    Text(
                      nombreUpc.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF06245B),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF06245B),
                      height: 2.0,
                    ),
                  ],
                )),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                  height: responsive.altoP(2),
                                  child:
                                      Image.asset(    package: AppConfig.namePackage,AppImages.imgDireccionIco)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Dirección:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Container(
                                width: responsive.anchoP(38),
                                child: Text(
                                  dir.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  height: responsive.altoP(2),
                                  child: Image.asset(AppImages.imgMailIco,    package: AppConfig.namePackage,)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Mail:           ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Container(
                                width: responsive.anchoP(38),
                                child: Text(
                                  mail.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  height: responsive.altoP(2),
                                  child: Image.asset(AppImages.imgTelefonoIco,    package: AppConfig.namePackage,)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Teléfono:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Container(
                                width: responsive.anchoP(38),
                                child: Text(
                                  telf.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  height: responsive.altoP(2),
                                  child:
                                      Image.asset(AppImages.imgDistanciaIco,    package: AppConfig.namePackage,)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Distancia:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Container(
                                width: responsive.anchoP(38),
                                child: Text(
                                  dist.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    color: Color(0xFF06245B),
                    height: 2.0,
                  ),
                  Container(
                    height: responsive.altoP(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => rutaGoogleMaps(
                            ctx: context,
                            longitudUpc: long1,
                            latitudUpc: lat1,
                            latitudIni: lat2,
                            longitudIni: long2,
                            nom: nombreUpc,
                          ),
                          // needed
                          child: Image.asset(
                            package: AppConfig.namePackage,
                            AppImages.imgRuta,
                            width: responsive.altoP(10),
                            //   fit: BoxFit.cover,
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              llamarTelefonoUpc(telf: telf, ctx: context),
                          // needed
                          child: Image.asset(
                            package: AppConfig.namePackage,
                            AppImages.imgTelefono,
                            width: responsive.altoP(10),
                            //   fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Ruta al Upc',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          'Llamar Upc',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFF06245B),
                    height: 2.0,
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void atras(BuildContext ctx) {
    Get.back();
  }

  static void rutaGoogleMaps(
      {required String latitudIni,
      required String longitudIni,
      required String latitudUpc,
      required String longitudUpc,
      required String nom,
      required BuildContext ctx}) async {
// String url ="https://maps.google.com/maps/search/?api=xfSpD_S_ZVzf0fv1p6JfVcMxjaB8&query="+latitud+","+longitud;
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=$latitudUpc,$longitudUpc&destination=$latitudIni,$longitudIni&travelmode=driving&dir_action=navigate';
    launchInBrowserView(Uri.parse(url));
  }

  static Future<void> launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  static void llamarTelefonoUpc({required String telf, required BuildContext ctx}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: telf,
    );
    await launchUrl(launchUri);
  }
}

Widget getCabecera() {
  final responsive = ResponsiveUtil();
  return Column(

    children: <Widget>[
      SizedBox(
        height: responsive.altoP(2),
      ),
      Row(    crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

        Container(
            height: responsive.altoP(4),
            child: Image.asset(AppImages.imgMarker_upc,    package: AppConfig.namePackage,)),
        const SizedBox(
          width: 6,
        ),
        SizedBox(
          width: responsive.altoP(12),
          child: Image.asset(AppImages.imgCabecera2,    package: AppConfig.namePackage,),
        ),
      ]),
    ],
  );
}
