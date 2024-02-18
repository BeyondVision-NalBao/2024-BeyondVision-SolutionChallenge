import 'package:beyond_vision/service/camera_service.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  /// Results to draw bounding boxes

  /// Realtime stats
  int totalElapsedTime = 0;
  int results = 0;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: CameraService(resultsCallback, updateElapsedTimeCallback));
  }

  void resultsCallback() {
    setState(() {
      results = 1;
    });
  }

  void updateElapsedTimeCallback(int elapsedTime) {
    setState(() {
      totalElapsedTime = elapsedTime;
    });
  }
}
