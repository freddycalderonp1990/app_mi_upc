part of '../pages.dart';

class AcuerdoPage extends GetView<AcuerdoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcuerdoController>(
      builder: (_) => getContenido(context),
    );
  }

  getContenido(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.imgarea),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Image.asset(AppImages.imgCabecera),
                    width: responsive.altoP(45),
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  width: responsive.ancho,
                  height: responsive.altoP(85),
                  child: SingleChildScrollView(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                      child: (Column(
                        children: <Widget>[
                          const Text(
                            'ACUERDO DE CONFIDENCIALIDAD DE LA INFORMACIÓN \n',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Text(
                              'Está aplicación ha sido desarrollada para brindar información relacionada con la localización de UPC, generar Alertas y otros servicios importantes para seguridad ciudadana, con la finalidad de mejorar el servicio a la ciudadanía, en tal virtud para su uso el usuario debe de aceptar los siguientes términos y condiciones: \n',
                              textAlign: TextAlign.justify),
                          const Text(
                              'La Información solicitada e ingresada en la aplicación es de carácter confidencial, reservada, y será utilizada con el propósito de mejorar el servicio a la ciudadanía a través de una herramienta con información real y segura.\n',
                              textAlign: TextAlign.justify),
                          const Text(
                              'La Policía Nacional del Ecuador no se responsabiliza de los costos relacionados con la conectividad de datos de acceso a internet utilizados por la aplicación para su funcionalidad.\n',
                              textAlign: TextAlign.justify),
                          const Text(
                              'La funcionalidad óptima de la aplicación dependerá de las características técnicas mínimas que debe cumplir el teléfono celular para su funcionamiento, señal de internet, empresa proveedora y ancho de banda al momento de la utilización de la aplicación.\n\nEsta aplicación ha sido desarrollada por la Policía Nacional del Ecuador, queda prohibida su reproducción y modificación parcial o total.\n',
                              textAlign: TextAlign.justify),
                          const Text(
                              'La violación de cualquiera de estos términos y condiciones, así como el mal uso del aplicativo tendrá como resultado el bloqueo de la aplicación y la sanción respectiva de acuerdo con la Normativa Legal vigente. Siendo el único responsable el USUARIO REGISTRADO en la aplicación.\n\n',
                              textAlign: TextAlign.justify),
                          const Text(
                              'En el artículo 396, numeral 3 del COIP dispone la sanción a la persona que de manera indebida realice uso del número único de atención de emergencias para dar un aviso falso de emergencia y que implique desplazamiento, movilización o activación innecesaria de recursos de las instituciones de emergencia.\n',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Divider(
                            color: AppConfig.colorBarras,
                          ),
                          Row(
                            children: <Widget>[
                              Obx(
                                () => Checkbox(
                                  value: controller.chk.value,
                                  onChanged: (check) {
                                    controller.chk.value =
                                        !controller.chk.value;
                                  },
                                ),
                              ),
                              Container(
                                //width: responsive.anchoP(80),
                                child: const Text(
                                  'Aceptar Términos y Condiciones',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Obx(() => controller.chk.isTrue
                                ? _btnRegistrar()
                                : Container()),
                          ),
                          Divider(
                            color: AppConfig.colorBarras,
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void ingresar(bool c) async {
    if (c == true) {
      controller.verificaAcuerdo();
      Get.offAllNamed(AppRoutes.REGISTROUSUARIO);
    } else {
      DialogosAwesome.getError(
          descripcion:
              'PARA CONTINUAR DEBE ACEPTAR LOS TÉRMINOS Y CONDICIONES DE USO DEL APLICATIVO.',
          title: 'Mi Upc',
          btnOkOnPress: () {
            // Get.back();
          });
    }
  }

  Widget _btnRegistrar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: MaterialButton(
        elevation: 5.0,
        onPressed: () => ingresar(controller.chk.value),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blueGrey[100],
        child: Text(
          'Siguiente',
          style: TextStyle(
            color: AppConfig.colorBarras,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
