
part of 'custom_widgets.dart';

class CargandoWidget extends StatefulWidget {


  final bool mostrar;


  const CargandoWidget({required this.mostrar}) ;

  @override
  _CargandoWidgetState createState() => _CargandoWidgetState();
}

class _CargandoWidgetState extends State<CargandoWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      widget.mostrar? Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),



                  Text("Espere...",style: TextStyle(fontSize: 15,color: Colors.white),)
                ],),
            ),
          ))
          : Container();
  }

}