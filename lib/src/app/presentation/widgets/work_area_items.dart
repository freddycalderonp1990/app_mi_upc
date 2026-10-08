part of 'custom_widgets.dart';

class WorkAreaItemsPageWidget extends StatefulWidget {
  final RxBool peticionServer;
  final String title;
  final String titleAppBar;
  final String name;
  final Widget contenido;
  final bool btnAtras;
  final VoidCallback? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final String? imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;
  final String? foto64;

  const WorkAreaItemsPageWidget({
    required this.peticionServer,
    this.title = '',
    this.titleAppBar = '',
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
  _WorkAreaItemsPageWidgetState createState() => _WorkAreaItemsPageWidgetState();
}

class _WorkAreaItemsPageWidgetState extends State<WorkAreaItemsPageWidget> {
  GpsController gpsController = Get.find<GpsController>();
  String ver = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      ver = _version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return SafeArea(child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(widget.titleAppBar),
      bottomNavigationBar: bannerInferior(responsive),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            /// Fondo completo, incluyendo área del status bar
            Positioned.fill(
              child: _buildBackground(responsive),
            ),

            /// Contenido protegido por SafeArea
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: widget.paddin ?? const EdgeInsets.all(6.0),
                  child: widget.contenido,
                ),
              ),
            ),

            /// Loader
            Obx(
                  () => CargandoWidget(
                mostrar: widget.peticionServer.value,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildBackground(ResponsiveUtil responsive) {
    return SizedBox(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo ?? AppImages.imgarea,
        fit: BoxFit.none,
      ),
    );
  }

  Widget imgBanner({
    required GestureTapCallback onTap,
    required String ruta,
    required ResponsiveUtil responsive,
  }) {
    double size = responsive.isVertical()
        ? responsive.altoP(8)
        : responsive.anchoP(8);
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(ruta),
        ),
      ),
    );
  }
  AppBar getAppBar(String titleAppBar) {
    final responsive = ResponsiveUtil();

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF06245B), Colors.grey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔹 Imagen seleccionada del menú anterior (si existe)
          if (widget.foto64 != null && widget.foto64!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: responsive.altoP(2.8),
                backgroundColor: Colors.white,
                backgroundImage: MemoryImage(base64Decode(widget.foto64!)),
              ),
            ),
          // 🔹 Título
          Flexible(
            child: Text(
              titleAppBar,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
      leading: widget.btnAtras
          ? Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 26,
          color: Colors.white,
          tooltip: 'Atrás',
          onPressed: widget.pantallaIrAtras ?? () => Get.back(),
        ),
      )
          : null,
    );
  }



  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [   Colors.grey,Color(0xFF06245B),],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Color(0xFF0A2A66), // mismo tono que AppBar o complementario
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
          border: Border.all(color: Colors.white30, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,

        ),
      ),
    );
  }

  static Future<void> launchURLFace() async {
    final url = Uri.parse('https://www.facebook.com/policia.ecuador');
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLTwitter() async {
    final url = Uri.parse('https://twitter.com/PoliciaEcuador');
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLInsta() async {
    final url = Uri.parse('https://www.instagram.com/policiaecuadoroficial');
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchURLYou() async {
    final url = Uri.parse('https://www.youtube.com/user/policiaecuador2');
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}
