part of 'custom_widgets.dart';

class DialogosAwesome {
  static getConTextImput(
      {String title = 'ERROR', required String descripcion}) {
    late AwesomeDialog dialog;
    dialog = AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      keyboardAware: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              'Form Data',
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                minLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedButton(
                isFixedHeight: false,
                text: 'Close',
                pressEvent: () {
                  dialog.dismiss();
                })
          ],
        ),
      ),
    )..show();
  }

  static getError(
      {String title = 'ERROR',
      required String descripcion,
      Function()? btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: title,
            desc: descripcion,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ?? () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  static getSucess(
      {String title = 'ÉXITO',
      required String descripcion,
      Function()? btnOkOnPress}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.topSlide,
      dialogType: DialogType.success,
      title: title,
      headerAnimationLoop: false,
      desc: descripcion,
      btnOkText: "Ok",
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: btnOkOnPress ??
          () {
            Get.back();
          },
    ).show();
  }

  static getWarning(
      {String title = 'Advertencia',
      required String descripcion,
      Function()? btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.warning,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            desc: descripcion,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnCancelText: "No",
            btnOkColor: Colors.deepOrangeAccent,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ??
                () {
                  Get.back();
                })
        .show();
  }

  static getWarningFoto(
      {String title = 'Advertencia',
      required String descripcion,
      Function()? btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.warning,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            desc: descripcion,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnCancelText: "No",
            btnOkColor: Colors.deepOrangeAccent,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ?? () {})
        .show();
  }

  static getWarningSiNo(
      {String title = 'ADVERTENCIA',
      required String descripcion,
      Function()? btnOkOnPress,
      Function()? btnCancelOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.warning,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            desc: descripcion,
            btnCancelText: "No",
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.blue,
            btnOkText: "Si",
            btnCancelOnPress: btnCancelOnPress ??
                () {
                  Get.back();
                },
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformation(
      {String title = 'Información', required String descripcion}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        desc: descripcion,
        btnCancelText: "Aceptar",
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        btnOkOnPress: () {
          Get.back();
        }).show();
  }

  static getInformationAceptar({
    String title = 'Información',
    required String descripcion,
    required Function() btnOkOnPress,
  }) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.info,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            desc: descripcion,
            btnCancelText: "Aceptar",
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSiNo(
      {String title = 'INFORMACIÓN',
      required String descripcion,
      Function()? btnOkOnPress,
      Function()? btnCancelOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.info,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            desc: descripcion,
            btnCancelText: "No",
            btnOkText: "Si",
            btnCancelOnPress: btnCancelOnPress ??
                () {
                  Get.back();
                },
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSi({
    String title = 'INFORMACIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: Get.context!,
            dialogType: DialogType.info,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: title,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            desc: descripcion,
            btnCancelText: "No",
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getPersonalizado(
      {String title = 'Información', required String descripcion}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      customHeader: const Icon(
        Icons.face,
        size: 50,
        color: Colors.black,
      ),
      title: 'This is Custom Dialod',
      desc: 'Confirm or cancel the deletion process',
      btnOk: TextButton(
        child: const Text('Cancel Button'),
        onPressed: () {
          Get.back();
        },
      ),
      //this is ignored
      btnOkOnPress: () {},
    ).show();
  }

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
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ?? () {})
        .show();
  }
}
