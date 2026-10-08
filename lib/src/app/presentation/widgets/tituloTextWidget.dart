part of 'custom_widgets.dart';
class TituloTextWidget extends StatelessWidget {

  final String title;

  final  Color colorTitulo ;
  final double ancho;
  final TextAlign textAlign;



  TituloTextWidget({required this.title,  this.colorTitulo= Colors.black, this.ancho=0, this.textAlign=TextAlign.start,});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    Widget wg;

    if(ancho==0){
      wg=Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: colorTitulo,
            fontWeight: FontWeight.bold,
            fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo)),
      );
    }
    else{
      wg=Container(
        width: responsive.anchoP(ancho),
        child: Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
              color: colorTitulo,
              fontWeight: FontWeight.bold,
              fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
        ),
      );
    }

    return wg;
  }
}


