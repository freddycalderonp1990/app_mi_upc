part of '../pages.dart';

class SplashPage extends GetView<SplashControllerMiUpc> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.colorPrimary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.colorPrimary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    final responsive = ResponsiveUtil();

    return GetBuilder<SplashControllerMiUpc>(
      builder: (_) => Scaffold(
        backgroundColor: AppColors.colorPrimary,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppImages.imgSplash, fit: BoxFit.cover,     package: AppConfig.namePackage,),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, .34, .72, 1],
                  colors: [
                    AppColors.colorPrimary.withOpacity(.16),
                    Colors.transparent,
                    AppColors.colorPrimary.withOpacity(.18),
                    AppColors.colorPrimary.withOpacity(.50),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: SizedBox(
                  height: responsive.diagonalP(40),
                  child: Image.asset(
                    package: AppConfig.namePackage,
                    AppImages.imgLoginHeader,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.anchoP(6),
                  ),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 850),
                    curve: Curves.easeOutCubic,
                    tween: Tween(begin: 0, end: 1),
                    builder: (context, value, child) => Transform.translate(
                      offset: Offset(0, 24 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    ),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 430),
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.anchoP(6),
                        vertical: responsive.altoP(3),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.08),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withOpacity(.14),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 28,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.anchoP(3),
                              vertical: responsive.altoP(1.2),
                            ),
                            child: Image.asset(
                              package: AppConfig.namePackage,
                              AppImages.imgEscpolicia,
                              width: double.infinity,
                              height: responsive.diagonalP(10),
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: responsive.altoP(1.8)),

                          Container(
                            width: responsive.diagonalP(14),
                            height: 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(.80),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: responsive.altoP(1.8)),

                          SizedBox(
                            width: responsive.diagonalP(13),
                            height: responsive.diagonalP(6),
                            child: Image.asset(
                              package: AppConfig.namePackage,
                              AppImages.imgloginPoliciaEcuador,
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: responsive.altoP(1.6)),

                          Text(
                            'SISTEMA INFORMÁTICO INTEGRADO\nDE LA POLICÍA NACIONAL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(.86),
                              fontSize: responsive.diagonalP(1.05),
                              fontWeight: FontWeight.w700,
                              letterSpacing: .8,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: responsive.altoP(2.4),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.55),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(height: responsive.altoP(.8)),
                    Text(
                      'POLICÍA NACIONAL DEL ECUADOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.62),
                        fontSize: responsive.diagonalP(.82),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

           CargandoWidget(
                mostrar: true,
                titulo: 'INICIANDO APP',
                mensaje: 'Preparando los servicios institucionales...',
              ),

          ],
        ),
      ),
    );
  }
}


