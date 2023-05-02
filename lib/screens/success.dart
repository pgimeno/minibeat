import 'package:flutter/material.dart';
import 'package:minibeat/models/artifact.dart';
import 'package:minibeat/models/hunted.dart';
import 'package:minibeat/screens/radar.dart';
import 'package:minibeat/utils/api.dart';

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
                Text(
                    'Has aconseguit la peça número ${widget.artifactToShow.ImageNumber.toString()}!'),
                Padding(
                  padding: const EdgeInsets.only(top: 55.0, bottom: 28.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'images/puzzle/${widget.artifactToShow.ImageNumber}.jpg',
                      width: 145,
                      height: 145,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.star, color: kMiniBeatMainColor),
                    SizedBox(width: 4),
                    Text(widget.artifactToShow.Points.toString(),
                        style: TextStyle(fontSize: 25)),
                  ],
                ),
                SizedBox(height: 34),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MenuScreen(playerLogged: widget.playerLogged))),
                  child: Text(
                    'Tornar al menú',
                    style: TextStyle(color: Colors.white),
                  ),
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
    print('S\'ha rebut l\'artifact, la seva img num és: ' +
        widget.artifactToShow.ImageNumber.toString());
    print('S\'ha rebut l\'artifact, la seva img num és: ' +
        widget.artifactToShow.Id.toString());
    print('S\'ha rebut el player, el seu nom és: ' +
        widget.playerLogged.userName.toString());
    print('S\'ha rebut el player, el seu nom és: ' +
        widget.playerLogged.id.toString());

    Hunted toInsert = Hunted(
        UserId: widget.playerLogged.id!,
        ArtifactId: widget.artifactToShow.Id,
        ArtifactImageNumber: widget.artifactToShow.ImageNumber,
        PointsGained: kpointsGainedByArtifact);
    insertNewHunted(toInsert);
  }

  void insertNewHunted(Hunted toInsert) async {
    print(toInsert.toString());
    await insertHunted(toInsert);
  }

  @override
  void initState() {}
}
