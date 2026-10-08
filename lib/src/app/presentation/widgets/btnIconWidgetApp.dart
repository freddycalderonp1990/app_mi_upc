part of 'custom_widgets.dart';

class BtnIconWidgetApp extends StatelessWidget {
  final String titulo;
  final String stringImg;
  final bool select;
  final VoidCallback? onPressed;

  const BtnIconWidgetApp(
      {Key? key,
      this.titulo = '',
      this.stringImg = '',
      this.select = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 10.0;
    final responsive = ResponsiveUtil();
    Widget wg = Container();

    wg = Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextButton.icon(
        label: Text(titulo,
            style: TextStyle(
                color: Colors.white, fontSize: responsive.diagonalP(1.5))),
        icon: Container(
          height: responsive.diagonalP(3),
          child:stringImg.length==0?Container(): Image.asset(stringImg),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: Colors.white.withOpacity(1))),
        ),
        onPressed: onPressed,
      ),
    );
    if (select) {
      wg = Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: TextButton.icon(
          label: Text(titulo,
              style: TextStyle(
                  color: Colors.white, fontSize: responsive.diagonalP(1.5))),
          icon: Container(
            height: responsive.diagonalP(3),
            child: stringImg.length==0?Container(): Image.asset(stringImg),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(width: 2, color: Colors.white),
            backgroundColor: AppColors.colorBotones,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: Colors.black.withOpacity(1))),
          ),
          onPressed: onPressed,
        ),
      );
    }

    return wg;

    return Expanded(
      child: wg,
    );
  }
}
