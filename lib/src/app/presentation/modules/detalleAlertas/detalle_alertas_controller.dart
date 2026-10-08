part of '../controllers.dart';

class DetalleAlertasController extends GetxController {
  /// ===================== 📊 VARIABLES =====================
  final RxBool peticionServerState = false.obs;

  final status = Rx<ConnectionStatus>(ConnectionStatus.online);
  final RxList<Catalogo> listaCatalogo = <Catalogo>[].obs;
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
  final AlertaViolenciaRepository _apiAlertaViolenciaRepository = Get.find<AlertaViolenciaRepository>();
  final MenuPrincipalController menuPrincipalController = Get.find<MenuPrincipalController>();
  late StreamSubscription connectionSubscription;
  String telefonoUsuario='';
  /// ===================== ⚙️ CICLO DE VIDA =====================
  @override
  void onReady() {
    super.onReady();
    connectionStatusController();
    consultaAlertasUsuario();
  }

  @override
  void onClose() {
    connectionSubscription.cancel();
    super.onClose();
  }

  /// ===================== 🌐 MONITOREO DE CONEXIÓN =====================
  void connectionStatusController() {
    connectionSubscription = internetChecker.internetStatus().listen(
          (newStatus) => status.value = newStatus,
    );
  }

  /// ===================== 🔍 CONSULTAR ALERTAS =====================
  Future<void> consultaAlertasUsuario() async {
    try {
      telefonoUsuario=await _localStoreImpl.getTelefono();
      int idGenPersona = await _localStoreImpl.getIdUser();
      if (idGenPersona == 0) {
        DialogosAwesome.getWarning(descripcion: "Usuario no autenticado.");
        return;
      }

     menuPrincipalController.listaAlertasUsuario.clear();
      peticionServerState(true);

      List<ListaAlerta> alertas =
      await _apiAlertaViolenciaRepository.consultaListaAlertasUsuario(idGenPersona);
      if (alertas.isNotEmpty) {
        menuPrincipalController.listaAlertasUsuario.assignAll(alertas);
      } else {
        DialogosAwesome.getInformation(btnOkOnPress: (){
          Get.back();
          Get.back();
        },
          descripcion: "No existen alertas registradas para este usuario.",
        );
      }
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    } catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(
        descripcion: "Error inesperado al consultar las alertas: $e",
      );
    }
  }

  Future<void> validarAlerta(int idAlerta, int idCatalogo, String estadoAlerta, String observacionAntendio) async {
    try {
      int idDinTurnosUsuariosAppAntedio = menuPrincipalController.listaPermiso.first.idDinUsuariosApp;
      String ip = await DeviceInfo.getIp;
      peticionServerState.value = true;

      // 🚀 Llamada al API
      ActualizaAlertaViolencia alerta = await _apiAlertaViolenciaRepository.actualizaAlertasUsuario(
        idDinAlertaApp: idAlerta,
        idDinTurnosUsuariosAppAntedio: idDinTurnosUsuariosAppAntedio,
        idDinCatalogosAppAntendio: idCatalogo,
        observacionAntendio: observacionAntendio,
        estadoAlerta: estadoAlerta,
        ip: ip,
      );

      peticionServerState.value = false;

      // 📋 Validar respuesta
      if (alerta.codeError == 0) {
        DialogosAwesome.getSucess(
          descripcion: "✅ La alerta ha sido validada correctamente.",
          btnOkOnPress: () => Get.back(),
        );
      } else {
        DialogosAwesome.getWarning(
          descripcion: alerta.msj.isNotEmpty ? alerta.msj : "Error al validar la alerta.",
        );
      }
    } catch (e, s) {
      peticionServerState.value = false;
      debugPrint("❌ Error en validarAlerta(): $e\n$s");
      DialogosAwesome.getError(descripcion: "Error al validar la alerta. Intente nuevamente.");
    }
  }

  consultaDatosCatalogoAlerta() async {
    try {
      listaCatalogo.clear();
      peticionServerState(true);
      List<Catalogo> catalogos = await _apiAlertaViolenciaRepository.consultaCatalogos(2);
      listaCatalogo.assignAll(catalogos); // 👈 Mantienes objetos completos
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
    }
  }
}
