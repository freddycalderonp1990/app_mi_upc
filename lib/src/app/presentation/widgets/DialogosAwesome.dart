part of 'custom_widgets.dart';




class DialogosAwesome {

  static  bool isDiaslogoShow= false;

  static Color colorWarning=Color(0xFFF46B40);
  static Color colorInformacion=AppColors.colorAzul;
  static Color colorError=Color(0xFFEA4236);
  static Color colorSucess=Color(0xFF10C26E);

  static String imgDefault=AppImages.escudopolicia;

  static getAlertDetalleServicios(
      {String title = 'INFORMACIÓN',
        required body,
        required imagen,
        Function()? btnOkOnPress,
        Function()? btnCancelOnPress}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        customHeader: imgPerfilRedonda(
          size: 20,
          img: imagen == '' ? null : imagen,
        ),
        headerAnimationLoop: true,
        animType: AnimType.bottomSlide,
        btnOkIcon: Icons.check_circle,
        body: body,
        btnOkColor: AppColors.colorBotones,
        btnOkText: "Ok",
        btnOkOnPress: btnOkOnPress ?? () {})
        .show();
  }

  static showIconPolicia(
      {
        bool mostrarSegungoBtn=true,
        Color colorBtnSi=AppColors.colorBotones,
        Color colorTitle=AppColors.colorAzul,
        Color colorCircleImg=AppColors.colorAzul,
        String imgString=AppImages.escudopolicia,

        required String title ,

        IconData iconBtnSi= Icons.check_circle_outline,
        IconData iconBtnNo= Icons.cancel_outlined,

        String titleBtnSi = 'Aceptar',
        String titleBtnNo = 'Cancelar',
        required String descripcion,
        required Function() btnOkOnPress,Function()? btnCancelOnPress}) {
    return _getIconPolicia(mostrarSegungoBtn: mostrarSegungoBtn, colorBtnSi: colorBtnSi, colorTitle: colorTitle,
        colorCircleImg:colorCircleImg,

        imgString: imgString, title: title, iconBtnSi: iconBtnSi,
        iconBtnNo:iconBtnNo,

        titleBtnSi: titleBtnSi, titleBtnNo: titleBtnNo, descripcion: descripcion,
        btnOkOnPress:btnOkOnPress, btnCancelOnPress:btnCancelOnPress
    );
  }

  static _getIconPolicia(
      {
        bool mostrarSegungoBtn=true,
        Color colorBtnSi=AppColors.colorBotones,
        Color colorTitle=AppColors.colorAzul,
        Color colorCircleImg=AppColors.colorAzul,
        String imgString=AppImages.escudopolicia,

        required String title ,

        IconData iconBtnSi= Icons.check_circle_outline,
        IconData iconBtnNo= Icons.cancel_outlined,

        String titleBtnSi = 'Aceptar',
        String titleBtnNo = 'Cancelar',
        required String descripcion,
        required Function() btnOkOnPress,Function()? btnCancelOnPress}) {

    if(isDiaslogoShow){
      return;
    }
    AwesomeDialog(
      dismissOnTouchOutside: false,

      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.info,

      headerAnimationLoop: true,
      customHeader: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorCircleImg, width: 3),
        ),
        child: Center(
          child: Image.asset(
            package: AppConfig.namePackage,
            imgString,
            width: 60, // Ajusta el tamaño para que no se recorte
            height: 60,
            fit: BoxFit.contain, // Mantiene proporciones
          ),
        ),
      ),
      animType: AnimType.scale,
      title: title,
      titleTextStyle: TextStyle(color: colorTitle,fontWeight: FontWeight.bold,fontSize: 18),

      btnCancel: BtnIconWidget(
        colorBtn: colorBtnSi,
        icon: iconBtnSi,
        onPressed: (){
          isDiaslogoShow=false;
          Get.back();
          if(btnOkOnPress!=null){
            btnOkOnPress();
          }

        },
        titulo: titleBtnSi,
      ),

      btnOk:!mostrarSegungoBtn?null: BtnIconWidget(

        colorBtn: AppColors.colorRojo_60,
        icon: iconBtnNo,
        onPressed: () {
          if (btnCancelOnPress != null) {
            isDiaslogoShow = false;
            Get.back();
            btnCancelOnPress(); // Ejecuta la función si está definida
          } else {
            isDiaslogoShow = false;
            Get.back();
          }
        },
        titulo: titleBtnNo,
      ),
      desc: descripcion,

    ).show();
  }


  static getWarning(
      {String title = 'ADVERTENCIA',
        String titleBtnOk = 'Ok',
        required String descripcion,
        Function()? btnOkOnPress}) {

    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorWarning,
      colorCircleImg: colorWarning,
      colorTitle: colorWarning,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );

  }


  static getWarningSiNoContador({
    String title = 'ADVERTENCIA',
    required String descripcion,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        int segundos = 5;
        bool botonesHabilitados = false;
        Timer? timer;

        return StatefulBuilder(
          builder: (context, setState) {
            // Inicia el temporizador solo una vez
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (segundos > 1) {
                setState(() => segundos--);
              } else {
                setState(() {
                  botonesHabilitados = true;
                  segundos = 0;
                });
                t.cancel();
              }
            });

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Encabezado
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 3),
                          ),
                          child: Center(
                            child: Image.asset(
                              package: AppConfig.namePackage,
                              AppImages.escudopolicia,
                              width: 60, // Ajusta el tamaño para que no se recorte
                              height: 60,
                              fit: BoxFit.contain, // Mantiene proporciones
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Descripción
                    /*   Text(
                      descripcion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),*/


                    TextoColorParser.textoConColores(
                      descripcion,
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Contador
                    if (!botonesHabilitados)
                      Column(
                        children: [
                          Text(
                            "Espere $segundos segundos...",
                            style: const TextStyle(
                              color: AppColors.colorAzul,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const CircularProgressIndicator(color: AppColors.colorAzul,),
                        ],
                      ),

                    if (botonesHabilitados)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Botón Sí
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text("Sí"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.colorBotones,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: btnOkOnPress==null ?
                                () {
                              Navigator.of(context).pop(true);
                            }:(){
                              Navigator.of(context).pop(true);
                              btnOkOnPress();
                            },
                          ),

                          // Botón No
                          ElevatedButton.icon(
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Text("No"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: btnCancelOnPress ??
                                    () {
                                  Navigator.of(context).pop(false);
                                },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  static getWarningSiNo(
      {String title = 'ADVERTENCIA',
        required String descripcion,
        Function()? btnOkOnPress,Function()? btnCancelOnPress}) {

    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorWarning,
      colorTitle: colorWarning,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "Si",
      mostrarSegungoBtn: true,
      titleBtnNo: "No",
      btnCancelOnPress: btnCancelOnPress == null
          ? () {

      }:btnCancelOnPress,
    );

  }



  static getError(
      {String title = 'ERROR',
        required String descripcion,
        Function()? btnOkOnPress}) {



    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorError,
      colorCircleImg: colorError,
      colorTitle: colorError,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );

  }

  static getSucess(
      {String title = 'ÉXITO',
        required String descripcion,
        Function()? btnOkOnPress}) {
    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorSucess,
      colorCircleImg: colorSucess,
      colorTitle: colorSucess,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );
  }



  static getInformation(
      {String title = 'INFORMACIÓN', required String descripcion,  Function()? btnOkOnPress,}) {


    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "Ok",
      mostrarSegungoBtn: false,
    );


  }



  static getInformationSiNo(
      {String title = 'INFORMACIÓN',
        required String descripcion,
        Function()? btnOkOnPress,
        Function()? btnCancelOnPress}) {

    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnNo: "No",
      titleBtnSi: "SI",
      mostrarSegungoBtn: true,
      btnCancelOnPress: btnCancelOnPress == null
          ? () {

      }:btnCancelOnPress,
    );
  }





  static getPersonalizado(
      {String title = 'Información', required String descripcion}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      customHeader: Icon(
        Icons.face,
        size: 50,
        color: Colors.black,
      ),
      title: 'This is Custom Dialod',
      desc: 'Confirm or cancel the deletion process',
      btnOk: TextButton(
        child: Text('Cancel Button'),
        onPressed: () {
          Get.back();
        },
      ),
      //this is ignored
      btnOkOnPress: () {},
    ).show();
  }

}





