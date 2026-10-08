part of '../../data_repositories.dart';

class AlertasDelitosApiImpl extends AlertasDelitosRepository {
  final AlertasDelitosApiProviderImpl alertasDelitosApiProviderImpl;

  AlertasDelitosApiImpl({required this.alertasDelitosApiProviderImpl});

  @override
  Future<List<CatalogoModel>> consultaCatalogos(int id) async {
    try {
      final response =
      await alertasDelitosApiProviderImpl.consultaCatalogos(id);
      return response;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<EventoEntity> crearEvento(EventoEntity evento) async {
    try {
      final model = EventoModel.fromEntity(evento);
      final response =
      await alertasDelitosApiProviderImpl.crearEvento(model);
      return response;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
