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
  final bool mostrarNotificacion;
  final double sizeTittle;
  final bool mostrarVersion;
  final foto64;
  final RxInt numNotificacion;

  const WorkAreaMenuPageWidget({
    required this.peticionServer,
    this.title = '',
    required this.mostrarNotificacion,
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
    required this.numNotificacion,
  });

  @override
  _WorkAreaMenuPageWidgetState createState() => _WorkAreaMenuPageWidgetState();
}

class _WorkAreaMenuPageWidgetState extends State<WorkAreaMenuPageWidget> {
  final GpsController gpsController = Get.find<GpsController>();
  final MenuPrincipalController menuController = Get.find<MenuPrincipalController>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  String ver = '';
  String estadoConex = '';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return SafeArea(
      child: Scaffold(
        key: _key,
        bottomNavigationBar: bannerInferior(responsive),
        drawer: _buildDrawer(context),
        appBar: getAppBar(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.imgFondo ?? AppImages.imgarea,
                  fit: BoxFit.cover,
                ),
              ),

              // ✅ El contenido ya no va dentro de SingleChildScrollView
              Column(
                children: [
                  if (widget.title.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(7),
                          color: const Color(0xFF06245B),
                        ),
                      ),
                    ),

                  if (widget.foto64 != null)
                    Column(
                      children: [
                        SizedBox(height: responsive.altoP(2.0)),
                        imgPerfilRedonda(size: 30, img: widget.foto64),
                        SizedBox(height: responsive.altoP(1.0)),
                        Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.anchoP(4.5),
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: responsive.altoP(2)),
                      ],
                    ),

                  // ✅ Esto permite que el contenido use Expanded/GridView sin romper
                  Expanded(
                    child: widget.contenido,
                  ),
                ],
              ),

              Obx(() => CargandoWidget(mostrar: widget.peticionServer.value)),
            ],
          ),
        ),
      ),
    );
  }

  // =======================================================
  // 🔹 BANNER INFERIOR SOCIAL
  // =======================================================
  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey, Color(0xFF06245B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, -2)),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          socialIconButton(iconPath: AppImages.imgFacebook, onTap: launchURLFace),
          socialIconButton(iconPath: AppImages.imgTwitter, onTap: launchURLTwitter),
          socialIconButton(iconPath: AppImages.imgInstagran, onTap: launchURLInsta),
          socialIconButton(iconPath: AppImages.imgYoutube, onTap: launchURLYou),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white30, width: 1),
        ),
        child: Image.asset(iconPath, width: 24, height: 24),
      ),
    );
  }

  // =======================================================
  // 🔹 APPBAR
  // =======================================================
  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF06245B), Colors.grey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.imgEdificio, height: 32),
          const SizedBox(width: 8),
          const Text(
            'MI UPC',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ],
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, size: 28, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
       /* if (widget.mostrarNotificacion)
          Obx(() {
            final int total = widget.numNotificacion.value;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 40),
                  color: Colors.white,
                  onPressed: () => Get.toNamed(AppRoutes.DETALLEALERTAS),
                ),
                if (total > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Center(
                        child: Text(
                          total.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),*/
      ],
    );
  }
  Widget _buildDrawerHeader({
    required ResponsiveUtil responsive,
    required Uint8List? bytes,
    required String nombre,
  }) {
    return FutureBuilder<String>(
      future: _localStoreImpl.getDatosMail(),
      builder: (context, snapshot) {
        final correo = (snapshot.data ?? '').trim();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.95),
                          Colors.white.withOpacity(0.58),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: responsive.altoP(5.2),
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                      bytes != null ? MemoryImage(bytes, scale: 1) : null,
                      child: bytes == null
                          ? Icon(
                        Icons.person_rounded,
                        size: responsive.altoP(4.6),
                        color: Colors.grey,
                      )
                          : null,
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF35C759),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                nombre.isNotEmpty ? nombre : "Usuario",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: responsive.diagonalP(1.24),
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 180),
                      child: Text(
                        correo.isNotEmpty ? correo : "email@dominio.com",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: responsive.diagonalP(0.82),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQuickStatusChip(
                    icon: Icons.verified_user_rounded,
                    text: 'Activo',
                  ),
                  const SizedBox(width: 8),
                  _buildQuickStatusChip(
                    icon: Icons.security_rounded,
                    text: 'Seguro',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  // =======================================================
  // 🔹 DRAWER LATERAL
  // =======================================================
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildDrawer(BuildContext context) {
    final responsive = ResponsiveUtil();

    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(32)),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0A2747).withOpacity(0.96),
                  const Color(0xFF11457F).withOpacity(0.92),
                  const Color(0xFF5D7286).withOpacity(0.86),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 10, 0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.dashboard_customize_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Menú principal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: responsive.diagonalP(0.82),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.14),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.redAccent.withOpacity(0.35),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.power_settings_new_rounded,
                              color: Colors.white,
                            ),
                            tooltip: 'Salir',
                            onPressed: () => exit(0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Obx(() {
                    final bytes = menuController.fotoPerfilBytes.value;
                    final nombre = menuController.userPref.value.trim();

                    return _buildDrawerHeader(
                      responsive: responsive,
                      bytes: bytes,
                      nombre: nombre,
                    );
                  }),

                  const SizedBox(height: 18),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _drawerItem(
                            icon: Icons.home_rounded,
                            label: "Inicio",
                            subtitle: "Volver a la pantalla principal",
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.offAllNamed(AppRoutes.SPLASH);
                            },
                          ),
                          const SizedBox(height: 10),
                          _drawerItem(
                            icon: Icons.share_rounded,
                            label: "Compartir App",
                            subtitle: "Enviar enlace de descarga",
                            onTap: () {
                              Navigator.of(context).pop();
                              Share.share(
                                "https://play.google.com/store/apps/details?id=com.miupc",
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          _drawerItem(
                            icon: Icons.person_rounded,
                            label: "Registrar / Editar Datos",
                            subtitle: "Actualizar información del usuario",
                            onTap: () {
                              Navigator.of(context).pop();
                              verificaTConexion();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        socialIconButtonD(AppImages.imgFacebook, launchURLFace),
                        socialIconButtonD(AppImages.imgTwitter, launchURLTwitter),
                        socialIconButtonD(AppImages.imgInstagran, launchURLInsta),
                        socialIconButtonD(AppImages.imgYoutube, launchURLYou),
                      ],
                    ),
                  ),
                  Text(
                    'v$ver ${AppConfig.ambiente}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _drawerItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.72),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.64),
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // =======================================================
  // 🔹 GPS / CONEXIÓN / URLS
  // =======================================================
  verificarGps() async {
    bool verificarGps = await gpsController.verificarGPS();
    if (verificarGps) {
      gpsController.iniciarSeguimiento();
      if (!gpsController.ubicacionLista.value) {
        DialogosAwesome.getInformation(
            descripcion: "Las coordenadas aún no están listas. Intente nuevamente.");
      } else {
        Get.toNamed(AppRoutes.REGISTROUSUARIO);
      }
    }
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        verificarGps();
      }
    } on SocketException {
      DialogosAwesome.getError(descripcion: 'No tiene conexión a Internet');
    }
  }

  static Future<void> launchURLFace() async =>
      launchUrl(Uri.parse('https://www.facebook.com/policia.ecuador'),
          mode: LaunchMode.inAppBrowserView);

  static Future<void> launchURLTwitter() async =>
      launchUrl(Uri.parse('https://twitter.com/PoliciaEcuador'),
          mode: LaunchMode.inAppBrowserView);

  static Future<void> launchURLInsta() async =>
      launchUrl(Uri.parse('https://www.instagram.com/policiaecuadoroficial'),
          mode: LaunchMode.inAppBrowserView);

  static Future<void> launchURLYou() async =>
      launchUrl(Uri.parse('https://www.youtube.com/user/policiaecuador2'),
          mode: LaunchMode.inAppBrowserView);

  Widget socialIconButtonD(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Image.asset(assetPath),
      ),
    );
  }
  Widget _buildQuickStatusChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
