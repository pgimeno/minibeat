import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minibeat/utils/api.dart';

import '../models/player.dart';
import '../utils/constants.dart';
Player currentPlayer = Player.empty();
List<int>? imgToShow = List<int>.empty(growable: true);

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  Map<String, dynamic> arguments = {};
  List<bool> _updatedIndexes = List.generate(16, (_) => false);
  double progres = 0.00;
  int pecesLeft = 16;

  @override
  void initState() {

  }

  void updatePuzzle(List<int> indexes) {
    if (indexes.length > 0){
      setState(() {
        _updatedIndexes = List.generate(16, (index) => indexes.contains(index));
      });

      updatePercentatgeProgres(indexes);
    }
  }

  void updatePercentatgeProgres(List<int> llistaDesbloquejades) {
    setState(() {
      progres = (llistaDesbloquejades.length / 16) * 100;
      pecesLeft = 16-llistaDesbloquejades.length;
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
    print('PLAYER ID: ${currentPlayer.id.toString()}');
    if (playerId != null) {
      List<int>? img  = await getHuntedArtifacts(playerId);
      setState(() {
        imgToShow = img;
        print('IMATGES: ${imgToShow.toString()}');
      });
      //Fer update de la llista de peces
      if(imgToShow == null){
        updatePuzzle(List<int>.empty());
      }else{
        updatePuzzle(imgToShow!);
      }
    }
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
              padding: const EdgeInsets.only(top: 30.0, bottom: 50),
              child: Text(
                'Completa el puzzle:',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Expanded(
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
            Padding(
              padding: const EdgeInsets.only(right: 14.0, left: 14.0, bottom: 100),
              child: Center(
                child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 22),
                          children: [
                            TextSpan(text: 'El teu progrés: '),
                            TextSpan(
                              text: '$progres%',
                              style: TextStyle(color: kMiniBeatMainColor, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                  SizedBox(height: 10),
                  if(pecesLeft != 0)
                  Text('Queden $pecesLeft peces per trobar!', style: TextStyle(fontSize: 17))else
                    Text('Felicitats! Has completat el puzzle!', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: kMiniBeatMainColor)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
