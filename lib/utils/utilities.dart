import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Utilities{
  final RegExp regExp = RegExp(r'^[a-zA-Z0-9_]+$');

  String hashPassword(String password){
    List<int> bytes = utf8.encode(password);
    Digest hash = sha256.convert(bytes);
    String hashString = hash.toString();
    return hashString;
  }
  showMessageDialog(BuildContext context, String title, String subtitle) {
    print("UTILITIES");
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      content: Text(
        subtitle,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String validateInput(String text, BuildContext context) {
    String sanitizedText = '';
    if (regExp.hasMatch(text)) {
      sanitizedText = text;
    } else {
      showMessageDialog(context, 'Caracters invàlids', 'Només es permeten lletres, números i barra baixa "_"');
    }
    return sanitizedText;
  }
}