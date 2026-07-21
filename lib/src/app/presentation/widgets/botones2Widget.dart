part of 'custom_widgets.dart';

class Botones2Widget extends StatefulWidget {
  final VoidCallback? onPressed;
  final String textoBtn;
  final double paddingVertical;


  const Botones2Widget({Key? key,required this.onPressed, this.textoBtn="", this.paddingVertical=10.0}) : super(key: key);

  @override
  _Botones2WidgetState createState() => _Botones2WidgetState();
}

class _Botones2WidgetState extends State<Botones2Widget> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.paddingVertical,horizontal: 10),
      width: double.infinity,
      child: TextButton(


        onPressed: widget.onPressed,

        child:
        Text(
          widget.textoBtn,
          style: TextStyle(
            color: Colors.blueGrey,
            letterSpacing: 1.5,
            fontSize:responsive.isVertical()?responsive.altoP(2.5):responsive.altoP(3) ,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}