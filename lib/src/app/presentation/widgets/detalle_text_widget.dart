part of 'custom_widgets.dart';


class DetalleTextWidget extends StatelessWidget {
  final String detalle;


  final  Color colorDetalle ;
  final double ancho;
  final  EdgeInsetsGeometry? padding;
  final bool todoElAncho;
  final double sizeText;
  final TextAlign? textAlign;

  const DetalleTextWidget({required this.detalle, this.colorDetalle=Colors.black, this.ancho=47, this.padding, this.todoElAncho=false, this.sizeText=AppConfig.tamTexto, this.textAlign=TextAlign.justify}) ;


  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    Widget text=Text(
      detalle,
      textAlign: textAlign,
      style: TextStyle(
          color: colorDetalle,
          fontSize: responsive.diagonalP(sizeText)),
    );


    return  Container(
        padding:padding==null?EdgeInsets.only(left: 5, right: 10, top: 0, bottom: 0):padding,

        child:!todoElAncho? Container(
          width: responsive.anchoP(ancho),
          child: text,
        ):Container(

          child: text,
        ) );
  }
}
