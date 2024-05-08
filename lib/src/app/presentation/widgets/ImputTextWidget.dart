part of 'custom_widgets.dart';

class ImputTextWidget extends StatefulWidget {
  final String? label;
  final Color colorLabel;
  final String? hitText;
  final FormFieldValidator<String>? validar;
  final bool isSegura;
  final double fonSize;
  final double elevation;
  final bool activar;
  final Icon? icono;
  final int maxLength;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  final String imgString;

  const ImputTextWidget({
    Key? key,
    this.label,
    this.validar,
    this.isSegura = false,
    this.fonSize = 17,
    this.elevation = 0.0,
    this.icono,
    this.activar = true,
    this.controller,
    this.maxLength = 0,
    this.hitText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.imgString = "",
    this.colorLabel = Colors.black,
  }) : super(key: key);

  @override
  _ImputTextWidgetState createState() =>
      _ImputTextWidgetState(isSegura: this.isSegura);
}

class _ImputTextWidgetState extends State<ImputTextWidget> {
  bool isSegura;

  _ImputTextWidgetState({this.isSegura = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();

    return Container(

      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.imgString == ""
              ? Container(
            child: widget.icono,
          )
              : Container(
            width: responsive.isVertical()
                ? responsive.altoP(4.3)
                : responsive.altoP(8),
            child: Image.asset(widget.imgString),
          ),
          SizedBox(
            width: responsive.anchoP(2),
          ),
          Expanded(
            child: widget.isSegura
                ? getTxtPass()
                : widget.maxLength > 0
                ? getTxtConLeng()
                : getTxtNormal(),
          ),
          SizedBox(
            width: 14,
          )
        ],
      ),
    );
  }

  InputDecoration getDecorationTxt() {
    return InputDecoration(


        labelText: widget.label,
        hintText: widget.hitText,
        contentPadding: EdgeInsets.symmetric(vertical: 10));
  }

  InputDecoration getDecorationTxtPass() {
    return InputDecoration(

        labelText: widget.label,
        hintText: widget.hitText,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isSegura ? Icons.visibility : Icons.visibility_off,
            color: AppColors.colorBotones,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              isSegura = !isSegura;
            });
          },
        ));
  }

  Widget getTxtNormal() {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      enabled: widget.activar,
      obscureText: widget.isSegura,
      validator: widget.validar,
      onChanged: widget.onChanged,
      cursorColor: AppColors.colorBordecajas,
      decoration: getDecorationTxt(),
    );
  }

  Widget getTxtConLeng() {
    return TextFormField(
      style: TextStyle(fontSize: widget.fonSize),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      enabled: widget.activar,
      obscureText: widget.isSegura,
      validator: widget.validar,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      cursorColor: AppColors.colorBordecajas,
      decoration: getDecorationTxt(),
    );
  }

  Widget getTxtPass() {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      enabled: widget.activar,
      obscureText: isSegura,
      onChanged: widget.onChanged,
      validator: widget.validar,
      cursorColor: AppColors.colorBordecajas,
      decoration: getDecorationTxtPass(),
    );
  }
}
