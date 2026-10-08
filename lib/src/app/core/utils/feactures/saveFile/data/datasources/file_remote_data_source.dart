
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../../../data/providers/providers_impl.dart';
import '../../domain/request/file_request.dart';
import '../models/file_model.dart';

abstract class FileRemoteDataSource {
  Future<bool> saveFile({required FileRequest request});

}

class FileRemoteDataSourceImpl implements FileRemoteDataSource {


  @override
  Future<bool> saveFile({required FileRequest request}) async {
    Map<String, String>? body = {
      "path":request.path,
      "nameFile":request.nameFile
    };

    UrlApiProviderApp _urlApiProviderApp = UrlApiProviderApp();

    String segmento = dotenv.env['API_SAVE_FILE'] ?? '';
    String url = HostApp.gethost( segmento: segmento);

    String json = await _urlApiProviderApp.postUploadFile(
      body: body, url: url, file: request.file, segmento: segmento,
    );

      return fileModelFromJson(json).dataFile;

  }
}


