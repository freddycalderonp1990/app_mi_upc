part of 'custom_widgets.dart';

class WorkAreaItemsPageWidget extends StatefulWidget {
  final  RxBool peticionServer;
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
  final  foto64;

  const WorkAreaItemsPageWidget({
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
  _WorkAreaItemsPageWidgetState createState() => _WorkAreaItemsPageWidgetState();
}

class _WorkAreaItemsPageWidgetState extends State<WorkAreaItemsPageWidget> {
  String ver='';
  @override
  void initState() {
    // TODO: implement initState
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
    Widget wgImgFondo = Container(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo ?? AppImages.imgarea,
        fit: BoxFit.fill,
      ),
    );

    Widget wgBtnAtras = Container(child:  widget.btnAtras
        ? BtnAtrasWidget(
      pantallaIrAtras: widget.pantallaIrAtras,
    )
        : Container(),
    );
    return Scaffold(
        bottomNavigationBar:   bannerInferior(responsive),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child:  SafeArea(child: Stack(
              children: [
                wgImgFondo,
                wgBtnAtras,
                Column(
                  children: [
                    SizedBox(height: responsive.altoP(3.0),),
                    widget.contenido,
                  ],
                ),
                Obx(()=>  CargandoWidget(
                  mostrar: widget.peticionServer.value,
                )
                )
              ],
            )),));
  }


  Widget imgBanner(
      {required GestureTapCallback onTap, required String ruta, required ResponsiveUtil responsive}) {
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


