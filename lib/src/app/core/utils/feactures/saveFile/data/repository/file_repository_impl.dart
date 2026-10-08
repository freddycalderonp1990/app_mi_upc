


import '../../domain/repository/file_repository.dart';
import '../../domain/request/file_request.dart';
import '../datasources/file_remote_data_source.dart';

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDataSource fileRemoteDataSource;

  FileRepositoryImpl({required this.fileRemoteDataSource});


  @override
  Future<bool> saveFile({required FileRequest request}) async {


   return fileRemoteDataSource.saveFile(request: request);
  }
}
