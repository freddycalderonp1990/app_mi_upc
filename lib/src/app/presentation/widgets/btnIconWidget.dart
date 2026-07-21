
part of 'custom_widgets.dart';

class BtnIconWidget extends StatelessWidget {
  final String? titulo;

  final VoidCallback? onPressed;

  final Color colorTxt;
  final Color colorLineas;
  final IconData? icon;
  final Color colorIcon;
  final Color colorBtn;
  final  double sizeTexto;
  final  double sizeIcon;

  const BtnIconWidget(
      {Key? key,
        this.titulo,

        required this.onPressed,
        this.colorTxt = Colors.white,
        this.colorLineas = Colors.black,
        this.icon,
        this.colorIcon = Colors.white,
        this.colorBtn=AppColors.colorBotones,  this.sizeTexto=AppConfig.tamTexto,  this.sizeIcon=AppConfig.tamIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 10.0;
    final responsive = ResponsiveUtil();
    Widget wg = Container();

    Widget iconWd = icon == null
        ? Container()
        : Icon(
      icon,
      color: colorIcon,
    );


    Widget iconButton=Container(
      decoration: BoxDecoration(
        color: colorBtn, // Fondo azul
        shape: BoxShape.circle, // Forma circular
      ),
      child: IconButton(
        icon: iconWd, // Ícono blanco
        onPressed: onPressed,
      ),
    );

    wg = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child:titulo==null?iconButton:

      TextButton.icon(
        label: Text(titulo!,
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: colorTxt,
                fontSize: responsive.diagonalP(sizeTexto))),
        icon: Container(
            height: responsive.diagonalP(sizeIcon), child: iconWd),
        style: TextButton.styleFrom(
          backgroundColor: colorBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: colorLineas)),
        ),
        onPressed: onPressed,
      ),
    );


    return wg;


  }
}

