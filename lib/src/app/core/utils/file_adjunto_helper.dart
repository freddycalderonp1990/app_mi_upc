import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import '../../data/models/models.dart';

class FileAdjuntoHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<AdjuntoModel?> tomarFotoDesdeCamara() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo == null) return null;

      final file = File(photo.path);
      return _crearAdjuntoDesdeRuta(file.path);
    } catch (e) {
      throw Exception('No fue posible tomar la foto: $e');
    }
  }

  static Future<AdjuntoModel?> grabarVideoDesdeCamara() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 2),
        preferredCameraDevice: CameraDevice.rear,
      );

      if (video == null) return null;

      final file = File(video.path);
      return _crearAdjuntoDesdeRuta(file.path);
    } catch (e) {
      throw Exception('No fue posible grabar el video: $e');
    }
  }

  static Future<AdjuntoModel?> seleccionarImagenGaleria() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return null;

      final file = File(image.path);
      return _crearAdjuntoDesdeRuta(file.path);
    } catch (e) {
      throw Exception('No fue posible seleccionar imagen desde galería: $e');
    }
  }

  static Future<AdjuntoModel?> seleccionarVideoGaleria() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      if (video == null) return null;

      final file = File(video.path);
      return _crearAdjuntoDesdeRuta(file.path);
    } catch (e) {
      throw Exception('No fue posible seleccionar video desde galería: $e');
    }
  }

  static Future<AdjuntoModel?> seleccionarArchivo() async {
    try {
      final result = await FilePicker.pickFiles(

        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'webp',
          'mp4',
          'mov',
          'avi',
          'mkv',
          '3gp',
          'heic',
        ],
      );

      if (result == null || result.isEmpty) {
        return null;
      }

      final picked = result.first;

      if (picked.path == null) return null;

      final mimeType =
          lookupMimeType(picked.path!) ?? 'application/octet-stream';

      if (!mimeType.startsWith('image/') && !mimeType.startsWith('video/')) {
        throw Exception('Solo se permiten archivos de imagen o video.');
      }

      final file = File(picked.path!);
      final extension = picked.extension ?? _extraerExtension(picked.name);

      return AdjuntoModel(
        file: file,
        nombre: picked.name,
        mimeType: mimeType,
        tamanioBytes: await file.length(),
        extension: extension,
      );
    } catch (e) {
      throw Exception('No fue posible seleccionar imagen o video: $e');
    }
  }

  static Future<AdjuntoModel> _crearAdjuntoDesdeRuta(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception('El archivo no existe.');
    }

    final nombre = p.basename(path);
    final mimeType = lookupMimeType(path) ?? 'application/octet-stream';

    if (!mimeType.startsWith('image/') && !mimeType.startsWith('video/')) {
      throw Exception('Solo se permiten archivos de imagen o video.');
    }

    final tamanioBytes = await file.length();
    final extension = _extraerExtension(nombre);

    return AdjuntoModel(
      file: file,
      nombre: nombre,
      mimeType: mimeType,
      tamanioBytes: tamanioBytes,
      extension: extension,
    );
  }

  static Future<AdjuntoModel> _mapearAdjunto(File file) async {
    final int tamanio = await file.length();
    final String nombre = p.basename(file.path);
    final String mimeType =
        lookupMimeType(file.path) ?? 'application/octet-stream';
    final String extension = _extraerExtension(nombre);

    return AdjuntoModel(
      file: file,
      nombre: nombre,
      mimeType: mimeType,
      tamanioBytes: tamanio,
      extension: extension,
    );
  }

  static String _extraerExtension(String nombreArchivo) {
    final parts = nombreArchivo.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    }
    return '';
  }

}