import 'dart:math';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show
    ArCoreController,
    ArCoreCube,
    ArCoreMaterial,
    ArCoreNode,
    ArCoreView,
    ArCoreViewType;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArScreen extends StatefulWidget {
    @override
    _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
    late ArCoreController arCoreController;

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: ArCoreView(
                    onArCoreViewCreated: _onArCoreViewCreated,
                ),
            ),
        );
    }

    void _onArCoreViewCreated(ArCoreController controller) {
        arCoreController = controller;

        _addCube(arCoreController);
    }

    Future<void> _addCube(ArCoreController controller) async {

        double xAxis = Random().nextDouble() * 5;
        double yAxis = Random().nextDouble() * 3;
        double zAxis = Random().nextDouble() * 6 - 3;

        print('Ubicacio x: '+xAxis.toString() +'y: '+ yAxis.toString() + 'z: '+zAxis.toString());

        final bytes = (await rootBundle.load('images/puzzle/1.jpg')).buffer.asUint8List();
        final material = ArCoreMaterial(
            color: Colors.black,
            textureBytes: bytes, // the bytes of your texture image
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
