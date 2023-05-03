import 'dart:convert';
import 'dart:math';
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

  double distanceBetweenPoints(double lat1, double long1, double lat2, double long2) {
    const double earthRadius = 6371000; // Radio de la Tierra en metros
    double dLat = radians(lat2 - lat1);
    double dLong = radians(long2 - long1);
    double a = pow(sin(dLat / 2), 2) +
        cos(radians(lat1)) *
            cos(radians(lat2)) *
            pow(sin(dLong / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double radians(double degrees) {
    return degrees * pi / 180;
  }

}