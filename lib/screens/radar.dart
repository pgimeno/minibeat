import 'package:flutter/material.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

String missatgeInicial = 'Mou-te pel recinte i atrapa els miniBeat';
String missatgeDetectat = 'S\'ha detectat un miniBeat a prop!';
bool isSearching = true;

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
    Timer(Duration(seconds: 5), () {
      setState(() {
        isSearching = false;
      });
    });
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
        print('tapped');
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
