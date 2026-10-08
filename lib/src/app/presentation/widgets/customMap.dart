part of 'custom_widgets.dart';

class CustomMap {
  static getMarkerMiUbicacion(Key key, LatLng punto) {
    double size = AppConfig.sizeMarcadorMiUbicacion;
    Marker marcador = Marker(
      width: size,
      height: size,
      point: punto,
      child: MarkerWidget(
        sizeIcon: 20,
        size: size,
        icon: Icons.person_pin_circle,
        key: key,
        colorIcon: Colors.blue,
        colorRelleno: Colors.white, onTap: () {  },
      ),
    );

    return marcador;
  }


  static Widget getBtnCustomIcon(
      {required GestureTapCallback ontap,
      required double size,
      required Color colorIcon,
      required Color colorRelleno,
      required IconData icon}) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(1),
        onPressed: ontap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  border: Border.all(color: colorIcon, width: 0.5),
                  color: colorRelleno,
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: size > 38
                    ? Icon(
                        icon,
                        color: colorRelleno,
                        size: size - 20,
                      )
                    : Container(),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: colorIcon, borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }

  static getMarkerRastro(
      {required Key key,
        required String num,
        required LatLng punto,
        required GestureTapCallback onTap,
        required final GestureLongPressCallback onLongPress,
      bool isTransparente = false,
        required bool valueCheck}) {
    double size = AppConfig.sizeMarcadorRastro;

    return MarkerRadioButton(
      num: num,
      size: size,
      icon: AppConfig.iconMarcadorRastro,
      key: key,
      colorIcon:
          isTransparente ? Colors.transparent : AppConfig.colorMarcadorRastro,
      colorRelleno: isTransparente ? Colors.transparent : Colors.white,
      isCheck: isTransparente ? false : true,
      onTap: onTap,
      valueCheck: valueCheck,
      onLongPress: onLongPress,
    );
  }
  static Widget getBtnCustomImg(
      {required GestureTapCallback ontap,
        required double size,
        required String icon}) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(1),
        onPressed: ontap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: Image.asset(icon),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }
  static Widget getBtnCustomLista(
      {required GestureTapCallback ontap,
        required String icon}) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(1),
        onPressed: ontap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: Image.asset(icon),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }
}
