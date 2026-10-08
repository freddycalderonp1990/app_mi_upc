

import '../repository/file_repository.dart';
import '../request/file_request.dart';

class SaveFileImgUseCase {
  final FileRepository repository;

  SaveFileImgUseCase({required this.repository});

  Future<bool> call({required FileRequest request}) {
    return repository.saveFile(request: request);
  }
}
