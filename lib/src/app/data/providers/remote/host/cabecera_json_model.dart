
part of '../../providers_impl.dart';

class CabeceraJsonModel {
  CabeceraJsonModel({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  final bool success;
  final int statusCode;
  final String message;

  factory CabeceraJsonModel.fromJson(String str) => CabeceraJsonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CabeceraJsonModel.fromMap(Map<String, dynamic> json) => CabeceraJsonModel(
    success: ParseModel.parseToBool( json["success"]),
    statusCode:ParseModel.parseToInt( json["status_code"]),
    message:ParseModel.parseToString( json["message"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
  };
}