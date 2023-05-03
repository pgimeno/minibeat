import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/models/artifact.dart';
import 'package:minibeat/models/player.dart';
import 'package:minibeat/screens/menu.dart';
import 'package:minibeat/screens/success.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show
        ArCoreController,
        ArCoreCube,
        ArCoreMaterial,
        ArCoreNode,
        ArCoreView,
        ArCoreViewType;

class ArScreen extends StatefulWidget {
  final Player playerLogged;
  final Artifact artifactToShow;

  ArScreen({required this.playerLogged, required this.artifactToShow});

  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  Map<String, dynamic> arguments = {};
  late ArCoreController arCoreController;


  @override
  void didChangeDependencies() {
    /*
    arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    artifactToShow = arguments['artifactToShow'];
    playerLogged = arguments['playerLogged'];
     */
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addCube(arCoreController, widget.artifactToShow.ImageNumber);

    arCoreController.onNodeTap = (node) {
      print('User tapped!!!!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SuccessScreen(artifactToShow: widget.artifactToShow, playerLogged: widget.playerLogged,)));
      /*Navigator.pushNamed(context, '/success',
          arguments: {'artifactHunted': artifactToShow});*/
    };
  }

  Future<void> _addCube(ArCoreController controller, int imageNum) async {
    double xAxis = Random().nextDouble() * 5;
    double yAxis = Random().nextDouble() * 3;
    double zAxis = Random().nextDouble() * 6 - 3;

    print('Ubicacio x: ' +
        xAxis.toString() +
        'y: ' +
        yAxis.toString() +
        'z: ' +
        zAxis.toString());

    final bytes = (await rootBundle.load('images/puzzle/$imageNum.jpg'))
        .buffer
        .asUint8List();
    final material = ArCoreMaterial(
      color: Colors.black,
      textureBytes: bytes,
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(1, 1, 1),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(xAxis, yAxis, zAxis),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
