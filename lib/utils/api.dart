import 'dart:convert';
import 'dart:io';
import 'package:minibeat/models/playerRanking.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../models/player.dart';
import 'package:http/io_client.dart';

Future<List<PlayerRanking>?> getRanking() async {
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  final response = await ioClient.get(
    Uri.parse('$kUrlApi/getRanking'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);

    print(jsonResponse.toString());
    List<PlayerRanking> players = List<PlayerRanking>.empty(growable: true);

    if (jsonResponse.isNotEmpty) {
      for (var playerJson in jsonResponse) {
        print('entra al for');

        String userName = playerJson['userName'];
        int totalPoints = playerJson['totalPoints'];
        int position = playerJson['position'];
        int avatarId = playerJson['avatarId'];

        print('variables assignades');

        PlayerRanking player = PlayerRanking(
            position: position, userName: userName, totalPoints: totalPoints, avatarId: avatarId);

        players.add(player);
      }
      print('retorna full llista');
      return players;
    }
  } else {
    print('retorna empty llista');
    return null;
  }
}

Future<Player?> checkUser(String userName) async {
  HttpClient httpClient = HttpClient()
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

Future<Player> registerUserApi(Player user) async {
  final url = Uri.parse('$kUrlApi/newUser/');
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = IOClient(httpClient);
  final response = await ioClient.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
  if (response.statusCode == 201) {
    return Player.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user.');
  }
}

//Mètode per omplir el menú principal de jugador
Future<PlayerRanking?> getPlayer(String playerName) async {
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  final response = await ioClient.get(
    Uri.parse('$kUrlApi/getRankingPosition/$playerName'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);

    if (jsonResponse.isNotEmpty) {
      return PlayerRanking.fromJson(jsonResponse[0]);
    } else {
      return null;
    }
  } else {
    throw Exception('Failed to get user');
  }
}

