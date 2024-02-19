import 'dart:io';
import 'dart:convert';
import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/model/workout_model.dart';
import 'package:beyond_vision/provider/login_provider.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_explain.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:typed_data';

import 'package:wakelock/wakelock.dart';

List<CameraDescription> cameras = [];

class CameraView extends StatefulWidget {
  final WorkOut workout;
  final int? count;
  const CameraView({super.key, required this.workout, this.count});

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late bool _isInitialized;
  bool _isStreamingPaused = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    _isInitialized = false;
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isInitialized = true;
      });
      _startStreaming();
    });
  }

  void _startStreaming() async {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    bool isReady =
        await getReady(auth.memberId, widget.workout.name, widget.count ?? 30);
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_isStreamingPaused) {
        _controller.takePicture().then((XFile? file) {
          if (file != null) {
            // 이미지 파일을 읽고 서버에 보내는 로직
            File imageFile = File(file.path);
            List<int> imageBytes = imageFile.readAsBytesSync();
            _sendFrameToServer(imageBytes);
          }
        });
      }
    });
  }

  Future<bool> getReady(
      int memberId, String exerciseName, int exerciseCount) async {
    final url = Uri.parse('http://34.64.89.205:5000/$memberId/start');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          "exerciseName": exerciseName,
          "exerciseCount": exerciseCount,
        }));
    if (response.statusCode == 200) {
      print("start는 성공?");
      return true;
    }
    return false;
  }

  void _sendFrameToServer(List<int> bytes) async {
    String url = 'http://34.64.89.205:5000/frame';
    try {
      // Send POST request with image bytes
      // 바이트 리스트를 Uint8List로 변환
      Uint8List uint8list = Uint8List.fromList(bytes);

      // Uint8List를 FormData에 추가
      FormData formData = FormData.fromMap({
        'frame': MultipartFile.fromBytes(
          uint8list,
          filename: 'image.png',
        ),
      });
      // Dio 인스턴스 생성
      Dio dio = Dio();

      // POST 요청 보내기
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      print(response.statusCode);
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
    _timer.cancel(); // 타이머 해제
    _controller.dispose();
    Wakelock.disable();
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
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CameraPreview(_controller),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color(boxColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Pause streaming when dialog is shown
                  setState(() {
                    _isStreamingPaused = true;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => WorkOutExplain(
                      workout: widget.workout,
                      pop: true,
                    ),
                  ).then((_) {
                    setState(() {
                      _isStreamingPaused = false;
                    });
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(speakerIcon, color: Color(fontYellowColor), size: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "설명 다시 듣기",
                          style: TextStyle(
                              fontSize: 36,
                              color: Color(fontYellowColor),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
