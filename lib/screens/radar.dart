import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minibeat/models/artifact.dart';
import 'package:minibeat/models/point.dart';
import 'package:minibeat/utils/api.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';
import '../models/player.dart';
import '../utils/utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


String missatgeInicial =
    'Mou-te pel recinte i atrapa totes les peçes del puzzle.';
String missatgeDetectat = 'S\'ha detectat una peça a prop!';
bool isSearching = true;
late Artifact artifactFound;
late Player playerLogged;
List<Artifact>? artifactsAvailable = List.empty(growable: true);

String checkMessageToShow() {
  if (isSearching) {
    return missatgeInicial;
  } else {
    return missatgeDetectat;
  }
}

class RadarScreen extends StatefulWidget {
  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  Map<String, dynamic> arguments = {};
  late PointGeo _currentPosition = PointGeo(0.0, 0.0);
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    _checkLocationPermission();
  }

  //Agafar la llista d'Artifacts disponibles per aquest usuari en aquest moment.
  getCurrentAvailableArtifacts() async{
    int? playerId = playerLogged.id;
    print('PLAYERID: $playerId');
    if (playerId != null) {
      artifactsAvailable = await getAvailableArtifacts(playerId);
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      isSearching = true;
    });
    //Take arguments
    arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    setState(() {
      playerLogged = arguments['userLogged'];
      print('ARGUMENTS PLAYERLOGGED: ${playerLogged.id.toString()}');
    });

    //Take list
    getCurrentAvailableArtifacts();
    print(artifactsAvailable.toString());


  }

  void _checkLocation() {
    // Check user location and update isSearching variable
    // For example, if user is within a certain radius of a location:
    for (Artifact ar in artifactsAvailable!) {
        print("LATITUDE ACTUAL ${_currentPosition.latitude}");
        double distanceInM = Utilities().distanceBetweenPoints(ar.Latitude, ar.Longitude, _currentPosition.latitude, _currentPosition.longitude);
        if (distanceInM<=distanceToSearch){
          print("ESTIC A MENYS DE DOS METRES");
          setState(() {
            artifactFound = ar;
            isSearching = false;

          });
        }
    }
  }


  Future<void> _checkLocationPermission() async {
    if (await Permission.location
        .request()
        .isGranted) {
      _positionStreamSubscription =
          Geolocator.getPositionStream(locationSettings: LocationSettings(accuracy: LocationAccuracy.bestForNavigation)).listen((Position position) {
            setState(() {
              _currentPosition = PointGeo(position.latitude, position.longitude);
              _checkLocation();
              print(_currentPosition.latitude.toString());
            });
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Permission Required'),
            content: Text('Please grant permission to access your location.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kMiniBeatGradientFirst,
              kMiniBeatGradientLast,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextMissatgeTop(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSearching) RadarBuscant() else RadarHasFound(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}

class RadarBuscant extends StatelessWidget {
  const RadarBuscant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpinKitRipple(
          color: kMiniBeatMainColor,
          borderWidth: 7,
          duration: Duration(seconds: 2, milliseconds: 500),
          size: 250.0,
        ),
        SizedBox(
          height: 100,
        ),
        Column(
          children: [
            Text(
              'El radar està funcionant',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            Text(
              'Buscant!',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class RadarHasFound extends StatelessWidget {
  const RadarHasFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CircleOpenCamera(),
        SizedBox(
          height: 100,
        ),
        BoxInfo(),
      ],
    );
  }
}

class BoxInfo extends StatelessWidget {
  const BoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'S\'obrirà la càmera',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        Text(
          'Busca el miniBeat al teu voltant',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    );
  }
}

class TextMissatgeTop extends StatelessWidget {
  const TextMissatgeTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 18, left: 18),
      child: Center(
          child: Text(
        checkMessageToShow(),
        style: TextStyle(color: Colors.white, fontSize: 23),
        textAlign: TextAlign.center,
      )),
    );
  }
}

class CircleOpenCamera extends StatelessWidget {
  const CircleOpenCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        Navigator.pushNamed(context, '/hunt', arguments: {
          'playerLogged': playerLogged,
          'artifactToShow': artifactFound
        });
      },
      child: Stack(
        children: [
          Container(
            width: 250.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: kMiniBeatMainColor,
              shape: BoxShape.circle,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Obrir la càmera!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
