import 'package:flutter/material.dart';
import 'package:minibeat/models/artifact.dart';

import '../models/player.dart';
import '../utils/constants.dart';
import 'menu.dart';

class SuccessScreen extends StatefulWidget {
  final Artifact artifactToShow;
  final Player playerLogged;

  SuccessScreen({required this.artifactToShow, required this.playerLogged});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Has aconseguit la peça número ${widget.artifactToShow.ImageNumber.toString()}!'),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MenuScreen(playerLogged: widget.playerLogged))),
                  child: Text('Tornar al menú'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
/*
    Artifact artifactToShow;
    arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    setState(() {
      artifactToShow = arguments['artifactHunted'];
      print('Artifact ID: ' +
          artifactToShow.Id.toString() +
          'Artifact Points: ' +
          artifactToShow.Points.toString());
    });*/

  }

  @override
  void initState() {}
}
