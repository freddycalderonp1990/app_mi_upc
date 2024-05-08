
part of 'custom_widgets.dart';

class MarkerRadioButton extends StatefulWidget {

  final Key key;
  final bool isCheck;
  final bool valueCheck;
  final GestureTapCallback onTap;
  final  GestureLongPressCallback onLongPress;
  final double size;
  final IconData icon;
  final Color colorIcon;
  final Color colorRelleno;
  final String num;

  const MarkerRadioButton(
      {required this.key, this.isCheck = false, this.valueCheck = true, required this.onTap, this.size = 38.0, required this.icon, this.colorIcon = Colors
          .blue, this.colorRelleno = Colors.white, required this.onLongPress,required this.num});

  @override
  _MarkerRadioButtonState createState() => _MarkerRadioButtonState();
}

class _MarkerRadioButtonState extends State<MarkerRadioButton> {
  @override
  Widget build(BuildContext context) {

    Widget wgRadioButton= InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.valueCheck ?
        Container(
          height: widget.size ,
          width: widget.size ,
          decoration: BoxDecoration(
              border: Border.all(color: widget.colorIcon, width: 0.5),
              color: widget.colorRelleno,
              borderRadius: BorderRadius.circular(50)),
          child: Container(
            child: widget.num==null? Icon(widget.icon, color: widget.colorRelleno, size: 10,):Center(child: Text(widget.num,style: TextStyle(color: widget.colorRelleno),),),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: widget.colorIcon,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        )

            : Container(
          height: widget.size ,
          width: widget.size ,
          decoration: BoxDecoration(
              border: Border.all(color: widget.colorIcon, width: 0.5),
              color: widget.colorRelleno,
              borderRadius: BorderRadius.circular(50)),
          child: Container(
            child: Icon(Icons.not_interested, color: widget.colorIcon, size: 10,),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: widget.colorRelleno,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        ),
      ),
    );

    return wgRadioButton;
  }
}


class MarkerWidget extends StatefulWidget {

  final Key key;
  final double size;
  final double sizeIcon;
  final IconData icon;
  final Color colorIcon;
  final Color colorRelleno;
  final GestureTapCallback onTap;
  const MarkerWidget(
      {required this.key, this.size = 38.0, required this.icon, this.colorIcon = Colors
          .blue, this.colorRelleno = Colors.white,this.sizeIcon=10, required this.onTap});

  @override
  _MarkerWidgetState createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {

    Widget wgMarkers=Container(
      height: widget.size ,
      width: widget.size ,
      decoration: BoxDecoration(
          border: Border.all(color: widget.colorIcon, width: 0.5),
          color: widget.colorRelleno,
          borderRadius: BorderRadius.circular(50)),
      child: Container(
        child: Icon(widget.icon, color: widget.colorRelleno, size: widget.sizeIcon,),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: widget.colorIcon,
            borderRadius: BorderRadius.circular(50)
        ),
      ),
    );

    return InkWell(
        onTap: widget.onTap,  child: Container(
      key: widget.key,
      child: wgMarkers,
    ));
  }


}
