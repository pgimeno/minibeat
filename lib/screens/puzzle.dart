import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<bool> _updatedIndexes = List.generate(16, (_) => false);
  double progres = 0.00;
  int pecesLeft = 16;

  void updatePuzzle(List<int> indexes) {
    setState(() {
      _updatedIndexes = List.generate(16, (index) => indexes.contains(index));
    });

    updatePercentatgeProgres(indexes);
  }

  void updatePercentatgeProgres(List<int> llistaDesbloquejades) {
    setState(() {
      progres = (llistaDesbloquejades.length / 16) * 100;
      pecesLeft = 16-llistaDesbloquejades.length;
    });
  }

  @override
  void didChangeDependencies() {
    //fer crida a la api de peçes disponibles per desbloquejar i tornar llista

    // i fer updatePuzzle(llistaRebudaPerApi);

    //updatePuzzle([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]);
    updatePuzzle([2,3,4,5,7,8,9,10,11,12,15]);
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
                  Text('Queden $pecesLeft peçes per trobar!', style: TextStyle(fontSize: 17))else
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
