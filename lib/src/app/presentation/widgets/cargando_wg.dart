
part of 'custom_widgets.dart';

class CargandoWidget extends StatelessWidget {
  final bool mostrar;
  final String titulo;
  final String mensaje;

  const CargandoWidget({
    Key? key,
    required this.mostrar,
    this.titulo = 'PROCESANDO INFORMACIÓN',
    this.mensaje = 'Espere un momento...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!mostrar) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.45),
                      AppColors.colorAzul_1.withOpacity(.38),
                      Colors.black.withOpacity(.60),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const AbsorbPointer(absorbing: true, child: SizedBox.expand()),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 330),
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(.18),
                        Colors.white.withOpacity(.06),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(.20),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colorAzul_1.withOpacity(.32),
                        blurRadius: 45,
                        spreadRadius: 3,
                        offset: const Offset(0, 14),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(.28),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Loading(radius: 30, dotRadius: 10),

                      const SizedBox(height: 25),

                      Text(
                        titulo,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          letterSpacing: 1.5,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        mensaje,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.72),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .3,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 3,
                          width: 150,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(.08),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.colorAzul_1.withOpacity(.90),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'SIIPNE APP',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.38),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



