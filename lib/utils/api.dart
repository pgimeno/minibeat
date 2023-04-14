import 'dart:convert';
import 'dart:io';
import 'package:minibeat/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../models/player.dart';
import 'package:http/io_client.dart';

Future<Player?> loginUser(String userName) async {
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  final response = await ioClient.get(
    Uri.parse('$kUrlApi/getUser/$userName'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);

    if (jsonResponse.isNotEmpty) {
      return Player.fromJson(jsonResponse[0]);
    } else {
      return null;
    }
  } else {
    throw Exception('Failed to check user');
  }
}
