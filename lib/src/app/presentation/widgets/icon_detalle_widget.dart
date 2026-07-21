part of 'custom_widgets.dart';
class IconDetalleWidget extends StatelessWidget {

  final String nameStringImg;
  final String detalle;
  final MainAxisAlignment mainAxisAlignment;
  final double sizeText;

  const IconDetalleWidget({Key? key, required this.nameStringImg, required this.detalle, this.mainAxisAlignment= MainAxisAlignment.start, this.sizeText=AppConfig.tamTexto}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget wg=Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          OnlyIconWidget(
            nameStringImg: nameStringImg,
          ),
          Flexible(
            child: DetalleTextWidget(

              sizeText: sizeText,

              detalle: detalle,
            ),
          )
        ]);
    
    return  wg ;
  }
}
