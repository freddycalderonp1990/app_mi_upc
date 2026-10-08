
import 'package:get/get.dart';


import 'data/datasources/file_remote_data_source.dart';
import 'data/repository/file_repository_impl.dart';
import 'domain/repository/file_repository.dart';
import 'domain/use_cases/save_file_img_use_case.dart';

class DependencyInjectionSaveFile  {

  static init() async {
    // Use cases

    Get.lazyPut(()=>SaveFileImgUseCase(repository: Get.find()), fenix: true);


    // Repository
    Get.lazyPut<FileRepository>(()=>FileRepositoryImpl(fileRemoteDataSource: Get.find()),fenix: true);


    // Data sources
    Get.lazyPut<FileRemoteDataSource>(()=>FileRemoteDataSourceImpl(), fenix: true);

  }
}
