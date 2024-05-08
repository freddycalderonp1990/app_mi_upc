part of 'models.dart';
class ParseModel {
  static int parseToInt(var value) {
    return value == null
        ? 0
        : value == ""
        ? 0
        : value is int
        ? value
        : int.parse(value);
  }

  static String parseToString(var value) {
    return value == null
        ? ""
        : value is String
        ? value
        : value is int ? value.toString():"";
  }

  static double parseToDouble(var value) {

    if(value==null){
      return 0;
    }

    value = value.toString().replaceAll(',', '.');

    double r = value == null
        ? 0
        : value == ""
        ? 0
        : value is double
        ? value
        : double.parse(value.toString());
    return (r);
  }

  static bool parseToBool(var value, {String? valueCompareTrue}) {
    if (valueCompareTrue != null) {
      return value == null
          ? false
          : value == ""
          ? false
          : value == valueCompareTrue
          ? true
          : false;
    }

    return value == null ? false : value;
  }
}
