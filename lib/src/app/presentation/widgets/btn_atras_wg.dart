part of 'custom_widgets.dart';

class BtnAtrasWidget extends StatelessWidget {
  final VoidCallback?  pantallaIrAtras;

  const BtnAtrasWidget({super.key, this.pantallaIrAtras});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: implement build
    return  Positioned(
        left: responsive.isVertical()
            ? responsive.altoP(2)
            : responsive.anchoP(2),
        top: responsive.isVertical()
            ? responsive.altoP(2)
            : responsive.anchoP(3),
        child: SafeArea(
          child: CupertinoButton(
            minSize: responsive.isVertical()
                ? responsive.altoP(6)
                : responsive.anchoP(5),
            padding: const EdgeInsets.all(3),
            borderRadius: BorderRadius.circular(35),
            color: Colors.black26,
            onPressed:pantallaIrAtras ?? () =>
                Get.back(),
            //volver atras
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: responsive.isVertical()
                  ? responsive.altoP(3.5)
                  : responsive.anchoP(3.5),
            ),
          ),
        ));
  }
}
