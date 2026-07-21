import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

class PhotoHelper{
  static Uint8List?  convertStringToUint8List(String? fotoString){

    try {
      Uint8List? imgDecode = null;
      if (fotoString != null && fotoString != '') {

        final decodedBytes = base64Decode(fotoString
            .toString()
            .split(',')
            .last);
        imgDecode = decodedBytes;

      }
      return imgDecode;
    }
    catch(e){
      log('Error al convertir imagen en ${e}');
    }
  }
}

