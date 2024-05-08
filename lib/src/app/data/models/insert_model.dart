part of 'models.dart';
InsertModel insertModelFromJson(String str) => InsertModel.fromJson(json.decode(str));

String insertModelToJson(InsertModel data) => json.encode(data.toJson());

class InsertModel {
  InsertModel({
    required this.insert,
  });

  Insert insert;

  factory InsertModel.fromJson(Map<String, dynamic> json) => InsertModel(
    insert: Insert.fromJson(json["insert"]),
  );

  Map<String, dynamic> toJson() => {
    "insert": insert.toJson(),
  };
}

class Insert {
  Insert({
    required this.codeError,
    required this.msj,
  });

  int codeError;
  String msj;

  factory Insert.fromJson(Map<String, dynamic> json) => Insert(
    codeError: json["codeError"],
    msj: json["msj"],
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
  };
}
