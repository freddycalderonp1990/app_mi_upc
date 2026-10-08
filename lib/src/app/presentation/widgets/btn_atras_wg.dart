part of 'custom_widgets.dart';

class BtnAtrasWidget extends StatelessWidget {
  final VoidCallback?  pantallaIrAtras;

  const BtnAtrasWidget({super.key, this.pantallaIrAtras});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: implement build
    return
      Column(children: [
        Positioned(
    left: responsive.isVertical()
    ? responsive.altoP(3)
        : responsive.anchoP(3),
    top: responsive.isVertical()
    ? responsive.altoP(2)
        : responsive.anchoP(3),
    child: CupertinoButton(
    padding: const EdgeInsets.all(3),
    borderRadius: BorderRadius.circular(35),
    color: Colors.black26,
    onPressed:pantallaIrAtras ?? () =>
    Get.back(),
    child: Icon(
    Icons.arrow_back,
    color: Colors.white,
    size: responsive.isVertical()
    ? responsive.altoP(4)
        : responsive.anchoP(4),
    ),
    ),
    ),
      ],);


  }
}
