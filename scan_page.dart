import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  bool _isCameraError = false;
  String? _cameraErrorMessage;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![0],
          ResolutionPreset.medium,
        );
        await _cameraController!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        setState(() {
          _isCameraError = true;
          _cameraErrorMessage = 'No camera found on this device.';
        });
      }
    } catch (e) {
      setState(() {
        _isCameraError = true;
        _cameraErrorMessage = 'Error initializing camera: $e';
      });
      print('Error initializing camera: $e');
    }
  }

  Future<String> _saveImage(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final File newImage = File(path);
    return newImage.writeAsBytes(await image.readAsBytes()).then((_) => path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Item'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          if (_isCameraInitialized)
            AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          if (_isCameraError)
            Center(
              child: Text(
                _cameraErrorMessage ?? 'Unknown error initializing camera.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isCameraInitialized
                ? () async {
                    if (_cameraController != null && _cameraController!.value.isInitialized) {
                      try {
                        XFile picture = await _cameraController!.takePicture();
                        String imagePath = await _saveImage(picture);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Picture saved at $imagePath')),
                        );
                      } catch (e) {
                        print('Error taking picture: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error taking picture: $e')),
                        );
                      }
                    }
                  }
                : null,
            child: Text('Capture'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
