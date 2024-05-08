
part of 'custom_widgets.dart';

class BtnIconWidget extends StatefulWidget {
  final IconData iconData;
  final title;
  final Color color;
  final Color colorTextoIcon;
  final GestureTapCallback onTap;
  final double elevation;
  final double size;
  final double paddinHorizontal;

  const BtnIconWidget(
      {required this.onTap,
      required this.iconData,
      this.title = "",
      required this.color,
      this.colorTextoIcon = Colors.black, this.elevation=2.0, this.size=5.0, this.paddinHorizontal=2.0});

  @override
  _BtnIconWidgetState createState() => _BtnIconWidgetState();
}

class _BtnIconWidgetState extends State<BtnIconWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.paddinHorizontal),
      child:  Material(
      color: widget.color,
      borderRadius: BorderRadius.circular(40),
      elevation: widget.elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: widget.onTap,
        // handle your onTap here
        child: Container(
          margin: EdgeInsets.all(responsive.anchoP(1.5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.iconData != null
                  ? Icon(
                widget.iconData,
                size: widget.size,
                color: widget.colorTextoIcon,
              )
                  : Container( width: responsive.anchoP(1) ,),
              widget.title != ""
                  ? SizedBox(
                width: responsive.anchoP(1),
              )
                  : SizedBox(
                width: responsive.anchoP(0),
              ),
              Text(
                widget.title,
                style: TextStyle(
                    color: widget.colorTextoIcon,
                    fontSize: widget.size),
              ),
              widget.title != ""
                  ? SizedBox(
                width: responsive.anchoP(2),
              )
                  : SizedBox(
                width: responsive.anchoP(0),
              )
            ],
          ),
        ),
      ),
    ),);
  }
}
