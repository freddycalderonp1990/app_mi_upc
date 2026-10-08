part of 'custom_widgets.dart';
class imgBanner extends StatefulWidget {
  final GestureTapCallback onTap;
  final String ruta;
  final ResponsiveUtil responsive;

  const imgBanner({
    super.key,
    required this.onTap,
    required this.ruta,
    required this.responsive,
  });

  @override
  State<imgBanner> createState() => _imgBannerState();
}

class _imgBannerState extends State<imgBanner> with SingleTickerProviderStateMixin {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final double size = widget.responsive.isVertical()
        ? widget.responsive.altoP(5)
        : widget.responsive.anchoP(5);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              widget.ruta,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
