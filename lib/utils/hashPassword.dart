import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:typed_data';

class HashMaker{

  String hashPassword(String password){
    List<int> bytes = utf8.encode(password);
    Digest hash = sha1.convert(bytes);
    String hashString = hash.toString();
    return hashString;
  }
}