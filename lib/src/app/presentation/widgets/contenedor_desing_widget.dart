
part of 'custom_widgets.dart';

class ContenedorDesingWidget extends StatelessWidget {
  final Widget child;
  final double anchoPorce;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? paddin;

  const ContenedorDesingWidget({
    Key? key,
    required this.child,
    this.anchoPorce = 97.0,
    this.margin,
    this.paddin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      final responsive = ResponsiveUtil();
      return Container(
padding: paddin,
          width: responsive.anchoP(anchoPorce),
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
              border: Border.all(color: AppColors.colorBordecajas,width: 2),
              ),
          child: child);

  }

}
