part of 'models.dart';

class GaleryCameraModel {
  final String title;
  final int tamImg;
  final String nombreImg;
  final File imageFile;
  final Img.Image image;
  final bool isHorizontal;
  final bool isVertical;

  GaleryCameraModel(
      {required this.title,
        required this.tamImg,
        required this.nombreImg,
        required this.imageFile,
        required this.image,
        this.isVertical = false,
        this.isHorizontal = false});
}