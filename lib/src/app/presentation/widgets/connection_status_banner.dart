part of 'custom_widgets.dart';

class ConnectionStatusBanner extends StatelessWidget {
  final Rx<ConnectionStatus> status;
  final VoidCallback? onInit;

  const ConnectionStatusBanner({
    super.key,
    required this.status,
    this.onInit,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => onInit?.call());

    return Obx(() {
      final online = status.value == ConnectionStatus.online;

      return Visibility(
        visible: !online,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 60,
          curve: Curves.easeInOutCubic,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB00020), Color(0xFFEF5350)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.wifi_off_rounded,
                        color: Colors.white, size: 26),
                    SizedBox(width: 10),
                    Text(
                      'Sin conexión a Internet',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _AnimatedReconnectLine(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


/// 🔹 Línea animada inferior que simula reconexión
class _AnimatedReconnectLine extends StatefulWidget {
  const _AnimatedReconnectLine();

  @override
  State<_AnimatedReconnectLine> createState() => _AnimatedReconnectLineState();
}

class _AnimatedReconnectLineState extends State<_AnimatedReconnectLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return FractionallySizedBox(
          widthFactor: _controller.value,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFEB3B),
                  Color(0xFFFDD835),
                  Color(0xFFFFC107),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}
