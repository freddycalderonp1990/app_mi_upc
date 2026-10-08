part of 'custom_widgets.dart';

class OpcionesUpcWidget {
  static Future opcionUpc({
    required BuildContext ctxt,
    required String nombreUpc,
    required String dir,
    required String mail,
    required String dist,
    required String telf,
    required String lat1,
    required String long1,
    required String lat2,
    required String long2,
    required String imagen,
  }) {
    final responsive = ResponsiveUtil();
    return showDialog(
      context: ctxt,
      barrierDismissible: true,
      builder: (context) {
        return AnimatedDialog(
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF06245B), Color(0xFF144580)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCabeceraElegante(responsive),
                  const SizedBox(height: 16),
                  _buildTitulo(nombreUpc),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 6),
                  _buildInfoItem(AppImages.imgDireccionIco, 'Dirección', dir),
                  _buildInfoItem(AppImages.imgMailIco, 'Email', mail),
                  _buildInfoItem(AppImages.imgTelefonoIco, 'Teléfono', telf),
                  _buildInfoItem(AppImages.imgDistanciaIco, 'Distancia', dist),
                  const SizedBox(height: 6),
                  const Divider(color: Colors.white70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAccion(
                        icono: AppImages.imgRuta,
                        label: 'Ruta al UPC',
                        onTap: () => rutaGoogleMaps(
                          ctx: context,
                          latitudIni: lat2,
                          longitudIni: long2,
                          latitudUpc: lat1,
                          longitudUpc: long1,
                          nom: nombreUpc,
                        ),
                      ),
                      _buildAccion(
                        icono: AppImages.imgTelefono,
                        label: 'Llamar UPC',
                        onTap: () => llamarTelefonoUpc(telf: telf, ctx: context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildCabeceraElegante(ResponsiveUtil responsive) {
    return      Column(
      children: [
        Container(
          height: responsive.altoP(4.5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.imgEdificio, height: responsive.altoP(3)),
              const SizedBox(width: 8),
              Image.asset(AppImages.imgCabecera2, height: responsive.altoP(3.5)),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildTitulo(String nombreUpc) {
    return Text(
      nombreUpc,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static Widget _buildInfoItem(String icono, String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Image.asset(icono, height: 10, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildAccion({
    required String icono,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(icono, width: 40),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static void atras(BuildContext ctx) => Get.back();

  static void rutaGoogleMaps({
    required String latitudIni,
    required String longitudIni,
    required String latitudUpc,
    required String longitudUpc,
    required String nom,
    required BuildContext ctx,
  }) {
    final mapaUpcController = Get.find<MapaUpcController>();
    mapaUpcController.createPolylines(
      inicioLat: double.parse(latitudIni),
      inicioLong: double.parse(longitudIni),
      finLat: double.parse(latitudUpc),
      finLong: double.parse(longitudUpc),
    );
    Get.back();
  }

  static void llamarTelefonoUpc({required String telf, required BuildContext ctx}) async {
    final Uri launchUri = Uri(scheme: 'tel', path: telf);
    await launchUrl(launchUri);
  }
}

class AnimatedDialog extends StatelessWidget {
  final Widget child;
  const AnimatedDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 400),
        tween: Tween<double>(begin: 0.8, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (context, double scale, _) {
          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, double opacity, _) {
              return Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
