import 'package:flutter/material.dart';
import 'package:minibeat/models/artifact.dart';
import 'package:minibeat/screens/ranking.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';
import '../models/player.dart';

String missatgeInicial =
    'Mou-te pel recinte i atrapa totes les peçes del puzzle.';
String missatgeDetectat = 'S\'ha detectat una peça a prop!';

bool isSearching = false;

late Artifact artifactFound;
Player? playerLogged = null;

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

  void checkLocation() {
    setState(() {
      isSearching = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    setState(() {
      playerLogged = arguments['userLogged'];
    });
    print('PANTALLA RADAR ACTIVADA, EL player Logged és: ');
    print(playerLogged!.userName.toString());
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

  @override
  void initState() {
    checkLocation();
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
    Vibration.vibrate(duration: 2000);

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
        artifactFound = Artifact(
            Id: 2,
            ImageNumber: 2,
            Points: 100,
            Latitude: 20.20,
            Longitude: 15.15);
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
