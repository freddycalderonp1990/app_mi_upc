
import 'dart:convert';

import '../../../../../../data/models/models.dart';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  final int statusCode;
  final String message;
  final bool dataFile;

  FileModel({
    required this.statusCode,
    required this.message,
    required this.dataFile,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataFile: ParseModel.parseToBool(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data":  dataFile,
  };


}
