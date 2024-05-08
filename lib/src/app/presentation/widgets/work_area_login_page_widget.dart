part of 'custom_widgets.dart';

class WorkAreaPageWidget extends StatefulWidget {
  final  RxBool peticionServer;
  final String title;
  final String name;
  final List<Widget> contenido;
  final bool btnAtras;
  final VoidCallback? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgPerfil;
  final imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;

  const WorkAreaPageWidget({
    required this.peticionServer,
    this.title = '',
    required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgPerfil = null,
    this.imgFondo,
    this.sizeTittle = 0,
    this.mostrarVersion = false,
    this.pantallaIrAtras,
    this.name = '',
  });

  @override
  _WorkAreaPageWidgetState createState() => _WorkAreaPageWidgetState();
}

class _WorkAreaPageWidgetState extends State<WorkAreaPageWidget> {
  String version = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      version = _version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();


    Widget wgImgFondo = Container(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo == null
            ? AppImages.imgarea
            : widget.imgFondo,
        fit: BoxFit.cover,
      ),
    );

    Widget wgImgPerfil = Center(
      child: Column(
        children: <Widget>[
          widget.imgPerfil != null
              ? imgPerfilRedonda(
            size: 22,
            img: widget.imgPerfil,
          )
              : Container(height: responsive.altoP(3)),
          widget.name != ''
              ? Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "",
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w300,
                fontSize: widget.sizeTittle == 0
                    ? responsive.anchoP(4)
                    : responsive.anchoP(widget.sizeTittle)),
          )
              : Container(),
          widget.title != ''
              ? Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
                fontSize: widget.sizeTittle == 0
                    ? responsive.anchoP(5)
                    : responsive.anchoP(widget.sizeTittle)),
          )
              : Container(),
          widget.mostrarVersion
              ? Text(
            'Versión 1: ' + version + ' ' + "UrlApi.ambiente",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          )
              : Container()
        ],
      ),
    );

    wgImgPerfil = Container(
      margin: EdgeInsets.only(
        top: responsive.altoP(1.0),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 45)
          ]),
      child: Stack(
        children: [
          widget.btnAtras
              ? BtnAtrasWidget(
            pantallaIrAtras: widget.pantallaIrAtras,
          )
              : Container(),
          wgImgPerfil
        ],
      ),
    );

    return Scaffold(
        floatingActionButtonLocation: widget.ubicacionBtnFinal,
        floatingActionButton: widget.widgetBtnFinal,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                wgImgFondo,
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            padding: widget.paddin,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  wgImgPerfil,
                                  Column(
                                    children: widget.contenido != null
                                        ? widget.contenido
                                        : [Container()],
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Obx(()=>  CargandoWidget(
                  mostrar: widget.peticionServer.value,
                ))
              ],
            )));
  }
}


