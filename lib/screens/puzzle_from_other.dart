import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minibeat/utils/api.dart';

import '../models/player.dart';
import '../utils/constants.dart';

Player currentPlayer = Player.empty();
List<int>? imgToShow = List<int>.empty(growable: true);

class PuzzleFromOtherScreen extends StatefulWidget {
  const PuzzleFromOtherScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleFromOtherScreen> createState() => _PuzzleFromOtherScreenState();
}

class _PuzzleFromOtherScreenState extends State<PuzzleFromOtherScreen> {
  bool _isLoading = true;
  Map<String, dynamic> arguments = {};
  List<bool> _updatedIndexes = List.generate(16, (_) => false);
  double progres = 0.00;
  int pecesLeft = 16;

  @override
  void initState() {}

  void updatePuzzle(List<int> indexes) {
    if (indexes.length > 0) {
      setState(() {
        _updatedIndexes = List.generate(16, (index) => indexes.contains(index));
      });

      updatePercentatgeProgres(indexes);
    }
  }

  void updatePercentatgeProgres(List<int> llistaDesbloquejades) {
    setState(() {
      progres = (llistaDesbloquejades.length / 16) * 100;
      pecesLeft = 16 - llistaDesbloquejades.length;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    setState(() {
      currentPlayer = arguments['userLogged'];
      getImgToShow();
    });
  }

  getImgToShow() async {
    int? playerId = currentPlayer.id;
    if (playerId != null) {
      List<int>? img = await getHuntedArtifacts(playerId);
      setState(() {
        imgToShow = img;
      });
      //Fer update de la llista de peces
      if (imgToShow == null) {
        updatePuzzle(List<int>.empty());
      } else {
        updatePuzzle(imgToShow!);
      }
    }

    _isLoading = false;
  }

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: Text(
                'Peces aconseguides per',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('${currentPlayer.userName}', style: TextStyle(color: kMiniBeatMainColor, fontSize: 30)),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'images/avatars/${currentPlayer?.avatarId}.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: _isLoading // show CircularProgressIndicator while loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                    padding: const EdgeInsets.only(top: 40, right: 28, left: 28),
                    child: GridView.builder(
                        itemCount: 16,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final imagePath = _updatedIndexes[index]
                              ? 'images/puzzle/${index}.jpg'
                              : 'images/minibeatlogo.png';
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                  ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 14.0, left: 14.0, bottom: 120),
              child: Center(
                child: Column(children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 22),
                      children: [
                        TextSpan(text: 'El seu progrés: '),
                        TextSpan(
                          text: '$progres%',
                          style: TextStyle(
                              color: kMiniBeatMainColorLighter,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (pecesLeft != 0)
                    Text('Li queden $pecesLeft peces per trobar!',
                        style: TextStyle(fontSize: 17))
                  else
                    Text('Ja ha completat el seu puzzle!',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kMiniBeatMainColorLighter)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
