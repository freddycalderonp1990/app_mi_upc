part of 'custom_widgets.dart';

class DialogosDesingWidget {
  static getDialogoX({String title = '', Widget? contenido, Widget? botones}) {
    final responsive = ResponsiveUtil();
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => new Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0,
        child: new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 5.0 + 16.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              margin: EdgeInsets.only(top: 0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius:
                BorderRadius.circular(AppConfig.radioBordecajas),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16.0,
                    offset: const Offset(0.0, 16.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: responsive.diagonalP(2.5),
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: responsive.altoP(1)),
                  contenido != null ? contenido : Container(),
                  SizedBox(height: responsive.altoP(1)),
                  Align(
                    alignment: Alignment.center,
                    child: botones != null ? botones : Container(),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: -10,
              child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  label: Container()),
            ),
          ],
        ),
      ),
    );
  }

  static getDialogoXClaveTemporal({String title = '', Widget? contenido, Widget? botones,required VoidCallback onPressedX}) {
    final responsive = ResponsiveUtil();
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => new Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0,
        child: new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 5.0 + 16.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              margin: EdgeInsets.only(top: 0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius:
                BorderRadius.circular(AppConfig.radioBordecajas),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16.0,
                    offset: const Offset(0.0, 16.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: responsive.diagonalP(2.5),
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: responsive.altoP(1)),
                  contenido != null ? contenido : Container(),
                  SizedBox(height: responsive.altoP(1)),
                  Align(
                    alignment: Alignment.center,
                    child: botones != null ? botones : Container(),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: -10,
              child: TextButton.icon(
                  onPressed: onPressedX,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  label: Container()),
            ),
          ],
        ),
      ),
    );
  }
  static getDialogoXImgMemory({String title = '', imgMemory}) {
    final responsive = ResponsiveUtil();
    Widget contenido = Container(
      height: responsive.altoP(50),
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: Image.memory(imgMemory).image, fit: BoxFit.cover),
        ),
      ),
    );

    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => new Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0,
        child: new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius:
                BorderRadius.circular(AppConfig.radioBordecajas),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16.0,
                    offset: const Offset(0.0, 16.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: responsive.diagonalP(2.5),
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: responsive.altoP(1)),
                  contenido != null ? contenido : Container(),
                  SizedBox(height: responsive.altoP(1)),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: -10,
              child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  label: Container()),
            ),
          ],
        ),
      ),
    );
  }


  static  selectPicture(BuildContext context,
      {GestureTapCallback? onTapGalery, GestureTapCallback? onTapCamara}) {
    final responsive = ResponsiveUtil();
    double radioBorder =AppConfig.radioBordecajas;


    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: AppColors.colorBordecajas, blurRadius: AppConfig.radioBordecajas)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(100),
                  decoration: BoxDecoration(
                      color: AppColors.colorBordecajas,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radioBorder),
                          topRight: Radius.circular(radioBorder))),
                  child: Center(
                    child: Text(
                      "Seleccionar la foto de:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(6),
                          color: Colors.white),
                    ),
                  ),
                ),
                //  SizedBox(height: responsive.altoP(3)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            height: responsive.altoP(5),
                            width: responsive.ancho,
                            child: Row(
                              children: [
                                Icon(Icons.picture_in_picture_alt_rounded),
                                SizedBox(
                                  width: responsive.anchoP(1),
                                ),
                                Text(
                                  "Galería",
                                  style: TextStyle(
                                      fontSize: responsive.altoP(2.5)),
                                ),
                              ],
                            ),
                          ),
                          onTap: onTapGalery,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Container(
                            height: responsive.altoP(5),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt),
                                  SizedBox(
                                    width: responsive.anchoP(1),
                                  ),
                                  Text(
                                    "Cámara",
                                    style: TextStyle(
                                        fontSize: responsive.altoP(2.5)),
                                  ),
                                ],
                              ),
                              onTap: onTapCamara,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => dialog);
  }

}
