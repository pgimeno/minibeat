import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants.dart';

class HuntActionScreen extends StatefulWidget {
  @override
  _HuntActionScreenState createState() => _HuntActionScreenState();
}

class _HuntActionScreenState extends State<HuntActionScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.medium,
    );
    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final microphoneStatus = await Permission.microphone.status;

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      _initializeCamera();
    } else {
      await _requestPermissions();
    }
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      _initializeCamera();
    } else {
      // Handle permission denial
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permissions Denied'),
            content: Text(
                'Please allow camera and microphone permissions to use this feature.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
              Text(
                'Busca el miniBeat pel teu voltant',
                style: TextStyle(fontSize: 24.0),
              ),
              _cameraController != null && _cameraController!.value.isInitialized
                  ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 5,
                      child: CameraPreview(_cameraController!),
                    ),
                  ],
                ),
              )
                  : Center(
                child: CircularProgressIndicator(),
              ),
              FloatingActionButton(
                onPressed:(){
                  print('Camera button pressed!');
                },
                child: Icon(Icons.camera_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
