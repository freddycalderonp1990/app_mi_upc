part of 'custom_widgets.dart';

class BouncingMarker extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String? label;

  const BouncingMarker({
    super.key,
    required this.icon,
    required this.color,
    this.label,
  });

  @override
  State<BouncingMarker> createState() => _BouncingMarkerState();
}

class _BouncingMarkerState extends State<BouncingMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 35, color: widget.color),
          if (widget.label != null)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4)
                ],
              ),
              child: Text(
                widget.label!,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }
}
