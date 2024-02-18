import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

List<CameraDescription> cameras = [];

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late bool _isInitialized;

  @override
  void initState() {
    super.initState();
    _isInitialized = false;
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.low);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isInitialized = true;
      });
      _startStreaming();
    });
  }

  void _startStreaming() async {
    if (!_controller.value.isStreamingImages) {
      await _controller.startImageStream((CameraImage image) {
        // Convert image to bytes
        List<int> bytes = image.planes[0].bytes;

        // Send bytes to Flask server
        _sendFrameToServer(bytes);
      });
    }
  }

  void _sendFrameToServer(List<int> bytes) async {
    String url = 'http://your-flask-server-url:5000/process_frame';
    try {
      // Send POST request with image bytes
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode({'image': base64Encode(bytes)}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle response from server if needed
        print('Frame processed successfully');
      } else {
        print('Failed to send frame to server');
      }
    } catch (e) {
      print('Error sending frame to server: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CameraPreview(_controller),
    );
  }
}
