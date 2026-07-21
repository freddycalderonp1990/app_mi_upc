import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncriptarUtil{
  static String generateMd5(String input) {

    return md5.convert(utf8.encode(input)).toString();
  }

  static String generateSha512(String input) {

    return sha512.convert(utf8.encode(input)).toString();
  }

  static String generateSha1(String input) {
    return sha1.convert(utf8.encode(input)).toString();
  }
}