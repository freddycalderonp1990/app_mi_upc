part of '../providers_impl.dart';

abstract class ModulosApiProvider {
  Future<List<Modulo>> buscaListaModulos();
  Future<DgoUsuariosAlertaApp> buscaPermisoBoton({
    required int idGenPersona,
    required String nomApp,
  });
}

class ModulosApiProviderImpl extends ModulosApiProvider {
  static String get _modulosAsset =>
      'packages/${AppConfig.namePackage}/assets/json/modulos.json';
  final Random _random = Random();

  @override
  Future<List<Modulo>> buscaListaModulos() async {
    // Simula la latencia variable del endpoint mientras se usa el JSON local.
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1501)));
    final contenido = await rootBundle.loadString(_modulosAsset);
    return modulosMiupcFromJson(contenido).upcModulosMovil.modulos
      ..sort((a, b) => a.ordenModulo.compareTo(b.ordenModulo));
  }

  @override
  Future<DgoUsuariosAlertaApp> buscaPermisoBoton({required int idGenPersona, required String nomApp}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idGenPersona":idGenPersona,
        "nomApp":nomApp,
        "opc":"v1-get-permiso-boton",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return permisoBotonModelFromJson(json).dgoUsuariosAlertaApp;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

}
