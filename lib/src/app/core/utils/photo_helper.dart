import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


import '../app_config.dart';
import '../values/app_images.dart';

class PhotoHelper {
  // ===================== 📸 DIALOGO DE SELECCIÓN =====================
  static Future<GaleryCameraModel?> getDesingPictureGaleryOrCamera({
    required String titleImg,
    required ValueChanged<bool> initPeticion,
  }) async {
    final completer = Completer<GaleryCameraModel?>();

    AwesomeDialog(
      context: Get.context!,
      animType: AnimType.bottomSlide,
      dialogType: DialogType.noHeader,
      padding: const EdgeInsets.all(5),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFE9ECEF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 14),
            const Text(
              "Seleccionar Imagen",
              style: TextStyle(
                color: Color(0xFF06245B),
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Toma una foto o selecciona una imagen de tu galería.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionCards(
              titleImg: titleImg,
              initPeticion: initPeticion,
              completer: completer,
            ),
          ],
        ),
      ),
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_rounded, color: Colors.redAccent),
    ).show();

    return completer.future;
  }

  // ===================== 🧭 CABECERA =====================
  static Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF195BA6).withOpacity(0.1),
      ),
      child: Image.asset(
        package: AppConfig.namePackage,
        AppImages.imgEdificio, // Reemplaza por un ícono elegante tipo 📷
        height: 65,
        fit: BoxFit.contain,
      ),
    );
  }

  // ===================== 🪄 OPCIONES COMO CARDS =====================
  static Widget _buildOptionCards({
    required String titleImg,
    required ValueChanged<bool> initPeticion,
    required Completer<GaleryCameraModel?> completer,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _optionCard(
          imageAsset: AppImages.imgCamara,
          label: "Cámara",
          color: const Color(0xFF195BA6),
          onTap: () async {
            Get.back();
            initPeticion(true);
            final data = await getImageCamera(titleImg);
            initPeticion(false);
            completer.complete(data);
          },
        ),
        SizedBox(width: 5,),
        _optionCard(
          imageAsset: AppImages.imgGaleria,
          label: "Galería",
          color: const Color(0xFF6C757D),
          onTap: () async {
            Get.back();
            initPeticion(true);
            final data = await getImageGallery(titleImg);
            initPeticion(false);
            completer.complete(data);
          },
        ),
      ],
    );
  }

  // ===================== 🧱 TARJETA DE OPCIÓN =====================
    static Widget _optionCard({
      required String imageAsset,
      required String label,
      required Color color,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTapDown: (_) {},
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 100,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.5), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  package: AppConfig.namePackage,
                  imageAsset,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      );
    }

  // ===================== 🖼️ FUENTES DE IMAGEN =====================
  static Future<GaleryCameraModel?> getImageGallery(String title) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    return getImageResource(title: title, imageFile: imageFile);
  }

  static Future<GaleryCameraModel?> getImageCamera(String title) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    return getImageResource(title: title, imageFile: imageFile);
  }

  // ===================== 🧠 PROCESAMIENTO DE IMAGEN =====================
  static Future<GaleryCameraModel?> getImageResource({
    required String title,
    XFile? imageFile,
  }) async {
    try {
      if (imageFile == null) return null;
      final bytes = await File(imageFile.path).readAsBytes();
      final image = Img.decodeImage(bytes);
      if (image == null) return null;
      return _resizeImage(title: title, image: image, maxSize: 900);
    } catch (e) {
      log("❌ Error procesando imagen: $e");
      return null;
    }
  }

  static Future<GaleryCameraModel> _resizeImage({
    required String title,
    required Img.Image image,
    required int maxSize,
  }) async {
    int alto = image.height;
    int ancho = image.width;
    double relacion = ancho / alto;

    if (alto > maxSize || ancho > maxSize) {
      if (alto > ancho) {
        ancho = (maxSize * relacion).round();
        alto = maxSize;
      } else {
        alto = (maxSize / relacion).round();
        ancho = maxSize;
      }
    }

    final resized = Img.copyResize(image, height: alto, width: ancho);
    final dir = await getTemporaryDirectory();
    final name =
        "img_${title}_${math.Random().nextInt(99999)}_.jpg";
    final file = File("${dir.path}/$name")
      ..writeAsBytesSync(Img.encodeJpg(resized, quality: 90));

    return GaleryCameraModel(
      title: title,
      tamImg: maxSize,
      nombreImg: name,
      imageFile: file,
      image: resized,
      isHorizontal: ancho >= alto,
      isVertical: alto > ancho,
    );
  }

  // ===================== 🔄 CONVERSIÓN STRING → BYTES =====================
  static Uint8List? convertStringToUint8List(String? fotoString) {
    try {
      if (fotoString != null && fotoString.isNotEmpty) {
        return base64Decode(fotoString.split(',').last);
      }
    } catch (e) {
      log('Error al convertir imagen: $e');
    }
    return null;
  }
}

// ===================== 🧩 MODELO DE IMAGEN =====================
class GaleryCameraModel {
  final String title;
  final int tamImg;
  final String nombreImg;
  final File imageFile;
  final Img.Image image;
  final bool isHorizontal;
  final bool isVertical;

  GaleryCameraModel({
    required this.title,
    required this.tamImg,
    required this.nombreImg,
    required this.imageFile,
    required this.image,
    this.isVertical = false,
    this.isHorizontal = false,
  });
}
