part of '../controllers.dart';

class AcuerdoController extends GetxController {
  final LocalStoreImpl _LocalStoreImpl = Get.find<LocalStoreImpl>();
  RxBool peticionServerState = false.obs;
  RxBool chk = false.obs;
  String acuerdo = "";

  @override
  void onInit() {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    _init();
  }

  _init() async {
    print(Get.deviceLocale.toString());
  }

  verificaAcuerdo() {
    _LocalStoreImpl.setDatosAcuerdo("Aceptado");
  }
}
