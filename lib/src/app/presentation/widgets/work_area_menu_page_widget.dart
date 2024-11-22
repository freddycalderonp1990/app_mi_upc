part of 'custom_widgets.dart';

class WorkAreaMenuPageWidget extends StatefulWidget {
  final RxBool peticionServer;
  final String title;
  final String name;
  final Widget contenido;
  final bool btnAtras;
  final VoidCallback? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;
  final foto64;

  const WorkAreaMenuPageWidget({
    required this.peticionServer,
    this.title = '',
    required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgFondo,
    this.sizeTittle = 0,
    this.mostrarVersion = false,
    this.pantallaIrAtras,
    this.name = '',
    this.foto64,
  });

  @override
  _WorkAreaMenuPageWidgetState createState() => _WorkAreaMenuPageWidgetState();
}

class _WorkAreaMenuPageWidgetState extends State<WorkAreaMenuPageWidget> {
  MiUpcGpsController gpsController = Get.find<MiUpcGpsController>();
  String ver = '';
  String userPref = '';
  String mailPref = '';
  String acuerdoPref = '';
  String estadoConex = "";

  @override
  void initState() {
    // TODO: implement initState
    _verificaDatos();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      ver = _version;
    });
  }

  final MiUpcLocalStoreImpl _localStoreImpl = Get.find<MiUpcLocalStoreImpl>();

  _verificaDatos() async {
    print("MENU: verificando datos");

    userPref = await _localStoreImpl.getDatosUsuario();
    acuerdoPref = await _localStoreImpl.getDatosAcuerdo();
    mailPref = await _localStoreImpl.getDatosMail();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    Widget wgImgFondo = SingleChildScrollView(
      child: Container(
        height: responsive.alto,
        width: responsive.ancho,
        child: Image.asset(
          widget.imgFondo ?? AppImages.imgarea,
          fit: BoxFit.fill,
        ),
      ),
    );

    return Scaffold(
        bottomNavigationBar: bannerInferior(responsive),
        key: _key,
        drawer: _buildDrawer(context),
        appBar: getAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    wgImgFondo,
                    Column(
                      children: [
                        widget.title == ''
                            ? Container()
                            : Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.anchoP(7),
                                  color: const Color(0xFF06245B),
                                ),
                              ),
                        widget.foto64 == null
                            ? Container()
                            : Container(
                                width: responsive.ancho,
                                margin: EdgeInsets.only(
                                  top: responsive.altoP(2.0),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.radioBordecajas),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.withOpacity(0.1),
                                          blurRadius: 20)
                                    ]),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      imgPerfilRedonda(
                                        size: 30,
                                        img: widget.foto64,
                                      ),
                                      SizedBox(
                                        height: responsive.altoP(1.0),
                                      ),
                                      Text(
                                        widget.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: responsive.anchoP(4.5),
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        widget.foto64 == null
                            ? Container()
                            : SizedBox(
                                height: responsive.altoP(2),
                              ),
                        widget.contenido,
                      ],
                    ),
                    Obx(() => CargandoWidget(
                          mostrar: widget.peticionServer.value,
                        ))
                  ],
                ),
              ),
            )));
  }

  Widget imgBanner(
      {required GestureTapCallback onTap,
      required String ruta,
      required ResponsiveUtil responsive}) {
    double size =
        responsive.isVertical() ? responsive.altoP(8) : responsive.anchoP(8);
    return Container(
        height: size,
        width: size,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                ruta,
              ),
            ),
          ),
        ));
  }

  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      height: responsive.altoP(5),
      color: Colors.blue[900],
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          imgBanner(
              onTap: launchURLFace,
              ruta: AppImages.imgFacebook,
              responsive: responsive),
          imgBanner(
              onTap: launchURLTwitter,
              ruta: AppImages.imgTwitter,
              responsive: responsive),
          imgBanner(
              onTap: launchURLInsta,
              ruta: AppImages.imgInstagran,
              responsive: responsive),
          imgBanner(
              onTap: launchURLYou,
              ruta: AppImages.imgYoutube,
              responsive: responsive),
        ],
      ),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: const Text(
        textAlign: TextAlign.justify,
        "MI UPC",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  // Drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  _buildDrawer(BuildContext context) {
    const String image = AppImages.imgEscpolicia;
    return ClipPath(
      /// ---------------------------
      /// Building Shape for drawer .
      /// ---------------------------
      // clipper: OvalRightBorderClipper(),

      /// ---------------------------
      /// Building drawer widget .
      /// ---------------------------
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary,
              boxShadow: const [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            /// ---------------------------
            /// Building scrolling  content for drawer .
            /// ---------------------------

            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // _localStoreImpl.setDatosMail('');
                        //_localStoreImpl.setDatosUsuario('');
                        //_localStoreImpl.setDatosAcuerdo('No Aceptado');
                        Get.back();
                        exit(0);
                      },
                    ),
                  ),

                  /// ---------------------------
                  /// Building header for drawer .
                  /// ---------------------------
                  Container(
                    height: 180,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.black54, Colors.blueAccent])),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                  const SizedBox(height: 5.0),

                  /// ---------------------------
                  /// Building header title for drawer .
                  /// ---------------------------

                  Text(
                    userPref != '' ? userPref : "Policia Nacional del Ecuador",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    mailPref != '' ? mailPref : "www.policia.gob.ec",
                    style: TextStyle(color: active, fontSize: 12.0),
                  ),

                  const SizedBox(height: 30.0),
                  _buildRow(Icons.home, AppRoutesMiUpc.nameMenuInit, onTap: () {
                    //oculta el drawer
                    _key.currentState?.openEndDrawer();

                    Get.offAllNamed(AppRoutesMiUpc.pageMenuInit);
                  }),
                  _buildDivider(),
                  _buildRow(Icons.share, "Compartir Aplicación",
                      showBadge: true, numNotificaciones: 0, onTap: () {
                    //oculta el drawer
                    Share.share(
                        "https://play.google.com/store/apps/details?id=mmeo.system.pne&hl=es");
                    _key.currentState?.openEndDrawer();
                  }),
                 /* _buildDivider(),
                  _buildRow(Icons.person_pin, "Perfil", onTap: () {
                    verificaTConexion();
                  }),*/

                  _buildDivider(),
                  Text(
                    'Versión: ' + ver + ' ' + AppConfig.ambiente,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  verificarGps() async {
    //se verifica si el GPS del dispositivo seta activo y tiene permisos
    bool verificarGps = await gpsController.verificarGPS();


    if (verificarGps) {
    //  gpsController.iniciarSeguimiento();
      // iniciarSeguimiento1();
      if (!gpsController.ubicacionLista.value) {
        DialogosAwesome.getInformation(
            descripcion: "Las coordenas aun no estan lista vuelva a intentar");
      } else {
        if (acuerdoPref == "Aceptado") {
          Get.toNamed(AppRoutesMiUpc.REGISTROUSUARIO);
        } else {
          Get.toNamed(AppRoutesMiUpc.ACUERDO);
        }
      }
    }
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        print('connected');
       // verificarGps();

        if (acuerdoPref == "Aceptado") {
          Get.toNamed(AppRoutesMiUpc.REGISTROUSUARIO);
        } else {
          Get.toNamed(AppRoutesMiUpc.ACUERDO);
        }
      }
    } on SocketException catch (_) {
      DialogosAwesome.getError(descripcion: 'No tiene conexión a Internet');
    }
  }

  /// ---------------------------
  /// Building divider for drawer .
  /// ---------------------------

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  /// ---------------------------
  /// Building item  for drawer .
  /// ---------------------------

  Widget _buildRow(IconData icon, String title,
      {bool showBadge = false,
      int numNotificaciones = 0,
      required GestureTapCallback onTap}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: active,
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: tStyle,
            ),
            Spacer(),
            // se dibuja las notificaciones
            if (showBadge && numNotificaciones > 0)
              Material(
                color: Colors.deepOrange,
                elevation: 5.0,
                shadowColor: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    numNotificaciones.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  launchURLFace() async {
    final url = Uri.parse('https://www.facebook.com/policia.ecuador');
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      print("Can't launch $url");
    }
  }

  launchURLTwitter() async {
    final url = Uri.parse('https://twitter.com/PoliciaEcuador');
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      print("Can't launch $url");
    }
  }

  launchURLInsta() async {
    final url = Uri.parse('https://www.instagram.com/policiaecuadoroficial');
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      print("Can't launch $url");
    }
  }

  launchURLYou() async {
    final url = Uri.parse('https://www.youtube.com/user/policiaecuador2');
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      print("Can't launch $url");
    }
  }
}


/// ------------------
/// for shaping the drawer. You can customize it as your own
/// ------------------
/*class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 60, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}*/
