import 'dart:convert';
import 'dart:io';
import 'package:minibeat/models/artifact.dart';
import 'package:minibeat/models/playerRanking.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../models/player.dart';
import 'package:http/io_client.dart';

//Retorna Ranking
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

        PlayerRanking player = PlayerRanking(
            position: position, userName: userName, totalPoints: totalPoints, avatarId: avatarId);

        players.add(player);
      }

      return players;
    }
  } else {
    return null;
  }
}

//Comprovar si existeix Usuari
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

//Fer registre d'un nou Usuari
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

Future<List<Artifact>?> getAvailableArtifacts(int userId) async {
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  final response = await ioClient.get(
    Uri.parse('$kUrlApi/getAvailableArtifacts/$userId'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);

    print(jsonResponse.toString());
    List<Artifact> artifacts = List<Artifact>.empty(growable: true);

    if (jsonResponse.isNotEmpty) {
      for (var artifactJson in jsonResponse) {
        print('Artifacts (entra al for)');

        int arId = artifactJson['Id'];
        int arImgNumber = artifactJson['ImageNumber'];
        int arPoints = artifactJson['Points'];
        double arLat = artifactJson['Latitude'];
        double arLong = artifactJson['Longitude'];

        Artifact ar = Artifact(Id: arId, ImageNumber: arImgNumber, Points: arPoints, Latitude: arLat, Longitude: arLong);

        artifacts.add(ar);
      }

      return artifacts;
    }
  } else {
    return null;
  }
}