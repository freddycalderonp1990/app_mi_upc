import 'dart:convert';
import 'dart:io';
import '../../data/providers/providers_impl.dart';
import 'my_File.dart';

class UploadImagenes{
  static Future<bool> upload ({required File image,required String nameImg}) async {
    String base64Image = base64Encode(image.readAsBytesSync());
    bool result = false;
    final file = await MyFile.writeFile(
        palabra: base64Image.toString(), name: nameImg);
    String json = await UrlApiProvider.getUrlUploadFile( file: file);
    print("upload img json ${json}");
    if (json == null) {
      print("upload img json false ${json}");
      return false;
    }
    else {
      if (json.toString().trim() == 'true')
        result = true;
      print("upload img json true ${json}");
      return result;
    }
  }



}