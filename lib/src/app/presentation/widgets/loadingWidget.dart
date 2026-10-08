part of 'custom_widgets.dart';

class Loading extends StatefulWidget {
  final double radius;
  final double dotRadius;

  Loading({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  late AnimationController controller;

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    // Animación de rotación para los dots
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.elasticIn)),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(0.0, 0.25, curve: Curves.elasticOut)),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.repeat();

    // Animación de scale (latido) para la imagen central
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    scaleAnimation = Tween(begin: 0.85, end: 1.1).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dots girando alrededor
          RotationTransition(
            turns: animation_rotation,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(8, (i) {
                final angle = i * pi / 4;
                final color = i % 2 == 0 ? Colors.blueAccent : Colors.grey;
                return Transform.translate(
                  offset: Offset(
                    radius * cos(angle),
                    radius * sin(angle),
                  ),
                  child: Dot(
                    radius: dotRadius,
                    color: color,
                  ),
                );
              }),
            ),
          ),

          // Imagen central con animación tipo latido
          ScaleTransition(
            scale: scaleAnimation,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                AppImages.imgEdificio,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
