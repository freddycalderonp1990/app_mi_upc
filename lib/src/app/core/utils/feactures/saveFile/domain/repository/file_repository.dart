


import '../request/file_request.dart';

abstract class FileRepository {
  Future<bool> saveFile({required FileRequest request});



}
