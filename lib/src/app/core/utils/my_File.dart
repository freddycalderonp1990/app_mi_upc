import 'dart:io';

import 'device_info.dart';
class MyFile{


  static Future<File> getFile(String name) async {
    final path = await DeviceInfo.getLocalPath;

    name=name.replaceAll('-', '_');
    name=name.replaceAll('.jpg', '');
    name=name.replaceAll('.png', '');
    name=name.replaceAll('.txt', '');


    String file='$path/'+name+'.json';

    print("getFile: ${file}");
    return File(file);
  }

  static Future<File> writeFile({String name='File',required String palabra}) async {
    final file = await getFile(name);
    // Escribir el archivo
    return file.writeAsString('$palabra');
  }


}