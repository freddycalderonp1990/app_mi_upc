part of 'models.dart';

class AdjuntoModel {
  final File file;
  final String nombre;
  final String mimeType;
  final int tamanioBytes;
  final String extension;

  AdjuntoModel({
    required this.file,
    required this.nombre,
    required this.mimeType,
    required this.tamanioBytes,
    required this.extension,
  });

  double get tamanioMb => tamanioBytes / (1024 * 1024);

  bool get superaCincoMb => tamanioBytes > 5 * 1024 * 1024;
}

