part of 'custom_widgets.dart';

class OnlyIconWidget extends StatelessWidget {
  const OnlyIconWidget({Key? key, this.size = 2.5, required this.nameStringImg, this.onTap}) : super(key: key);
  final double size;
  final String nameStringImg;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return InkWell(child: Image.asset(
      nameStringImg,
      height: responsive.diagonalP(size),
    ),onTap:onTap,);
  }
}
