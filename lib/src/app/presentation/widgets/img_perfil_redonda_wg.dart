part of 'custom_widgets.dart';

class imgPerfilRedonda extends StatefulWidget {
  final double size;

  final img;

  const imgPerfilRedonda({Key? key, this.size = 22, this.img})
      : super(key: key);

  @override
  _imgPerfilRedondaState createState() => _imgPerfilRedondaState();
}

class _imgPerfilRedondaState extends State<imgPerfilRedonda> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    var imgMemory = null;
    if (widget.img != null) {
      imgMemory = PhotoHelper.convertStringToUint8List(widget.img);
    }

    return widget.img != null
        ? Container(
      width: responsive.isVertical()
          ? responsive.anchoP(widget.size)
          : responsive.anchoP(widget.size - 8),
      height: responsive.isVertical()
          ? responsive.anchoP(widget.size)
          : responsive.anchoP(widget.size - 8),
    /*  decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF6E6506),
          style: BorderStyle.solid,
          width: 4.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(200.0),
      ),*/
      child: imgMemory != null
          ? Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: Image.memory(imgMemory).image,
              fit: BoxFit.fill),
        ),
      )
          : ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(65.0)),
        child: Image.asset(
          AppImages.imgEscpolicia,
        ),
      ),
    )
        : Container();



  }
}