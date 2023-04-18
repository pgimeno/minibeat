import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants.dart';

class HuntActionScreen extends StatefulWidget {
  @override
  _HuntActionScreenState createState() => _HuntActionScreenState();
}

class _HuntActionScreenState extends State<HuntActionScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _checkCameraPermission();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    setState(() {});
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        _isCameraPermissionGranted = true;
      });
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _isCameraPermissionGranted = true;
      });
    } else if (status.isDenied) {
      // Handle permission denial
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Camera Permission Denied'),
            content:
                Text('Please allow camera permission to use this feature.'),
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
                'Sample text 1',
                style: TextStyle(fontSize: 24.0),
              ),
              _cameraController.value.isInitialized
                  ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 5,
                            child: CameraPreview(_cameraController),
                          ),
                        ],
                      ),
                  )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              FloatingActionButton(
                onPressed: _requestCameraPermission,
                child: Icon(Icons.camera_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
