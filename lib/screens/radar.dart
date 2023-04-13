import 'package:flutter/material.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RadarScreen extends StatefulWidget {
  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  String missatgeInicial = 'Mou-te pel recinte i atrapa els miniBeat';
  bool isSearching = true;

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
              TextMissatgeTop(missatgeInicial: missatgeInicial),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSearching) RadarBuscant() else Column(),
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
          duration: Duration(milliseconds: 500),
          size: 250.0,
        ),
        SizedBox(
          height: 100,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.black26.withAlpha(1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'El radar està funcionant',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                'Buscant!',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TextMissatgeTop extends StatelessWidget {
  const TextMissatgeTop({
    super.key,
    required this.missatgeInicial,
  });

  final String missatgeInicial;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      missatgeInicial,
      style: TextStyle(color: Colors.black, fontSize: 26),
      textAlign: TextAlign.center,
    ));
  }
}
