import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class CameraSettings {
  // 카메라 프리뷰의 가로 세로 비율을 저장하는 변수
  static double? ratio;
  // 화면 크기를 저장하는 변수
  static Size? screenSize;
  // 입력 이미지 크기를 저장하는 변수
  static Size? inputImageSize;
  // 실제 프리뷰 크기를 계산하여 반환하는 getter
  static Size get actualPreviewSize => Size(
        // 화면의 너비
        screenSize?.width ?? 0,
        // 화면의 너비에 비율을 곱하여 높이를 계산
        (screenSize?.width ?? 0) * (ratio ?? 0),
      );
}

class CameraService extends StatefulWidget {
  // 결과를 반환하기 위한 콜백 함수
  final Function() resultsCallback;
  // 추론 시간을 업데이트하기 위한 콜백 함수
  final Function(int elapsedTime) updateElapsedTimeCallback;
  // CameraView 생성자
  const CameraService(this.resultsCallback, this.updateElapsedTimeCallback,
      {super.key});
  @override
  _CameraServiceState createState() => _CameraServiceState();
}

class _CameraServiceState extends State<CameraService>
    with WidgetsBindingObserver {
  // 사용 가능한 카메라 목록
  List<CameraDescription>? cameras;
  // 카메라 컨트롤러
  CameraController? cameraController;
  // 추론 중일 때 true
  bool? predicting;
  // Classifier 인스턴스
  // Classifier? classifier;
  // IsolateUtils 인스턴스
  // IsolateUtils? isolateUtils;
  int count = 0;
  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);
    // 새로운 Isolate를 생성
    // isolateUtils = IsolateUtils();
    // await isolateUtils?.start();
    // 카메라 초기화
    initializeCamera();
    // 모델 및 레이블을 로드하기 위해 Classifier 인스턴스 생성
    // classifier = Classifier();
    // 초기에 predicting은 false로 설정
    predicting = false;
  }

  // 카메라를 초기화하고 cameraController를 설정
  void initializeCamera() async {
    cameras = await availableCameras();
    // cameras[0]은 후면 카메라
    cameraController =
        CameraController(cameras![1], ResolutionPreset.low, enableAudio: false);
    predicting = await getReady(3, "스쿼트", 20);
    cameraController?.initialize().then((_) async {
      // onLatestImageAvailable 함수를 전달하여 각 프레임에 대한 인식을 수행

      await cameraController?.startImageStream(onLatestImageAvailable);

      //프레임마다 호출

      // 현재 카메라의 미리보기의 크기
      Size? previewSize = cameraController?.value.previewSize;
      CameraSettings.inputImageSize = previewSize;
      // 해당 스마트폰의 화면의 크기
      Size screenSize = MediaQuery.of(context).size;
      CameraSettings.screenSize = screenSize;
      // 프리뷰 프레임의 너비와 화면 너비 간의 비율
      CameraSettings.ratio = screenSize.width / (previewSize?.height ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 카메라가 초기화되지 않은 경우 빈 컨테이너 반환
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }
    // 카메라 프리뷰
    return AspectRatio(
      //카메라 프리뷰 화면의 가로 세로 비율
      aspectRatio: 1 / cameraController!.value.aspectRatio,
      child: CameraPreview(cameraController!),
    );
  }

  // 프레임마다 호출
  onLatestImageAvailable(CameraImage cameraImage) async {
    // if (mounted) {
    //   setState(() {
    //     predicting = false;
    //   });
    // }

    // if (classifier?.interpreter != null && classifier?.labels != null) {
    //   // 이전 추론이 완료되지 않은 경우 반환
    //   if (predicting ?? false) {
    //     return;
    //   }
    //   setState(() {
    //     // 이전 추론 완료
    //     predicting = true;
    //   });
    //   //추론 시작 시간
    if (predicting == true) {
      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;
      //   // 추론 Isolate에 전달할 데이터
      //   var isolateData = IsolateData(cameraImage,
      //       classifier?.interpreter?.address ?? 0, classifier?.labels ?? []);
      //   // 추론 결과 반환
      bool result = await sendImage(cameraImage);
      //   // 추론 시간 계산
      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;
      //   // 결과를 HomeView로 전달
      widget.resultsCallback();
      // 추론 시간 HomeView로 전달
      widget.updateElapsedTimeCallback(uiThreadInferenceElapsedTime);
      // 새로운 프레임을 허용하기 위해 predicting을 false로 설정

      setState(() {
        predicting = false;
      });

      print(uiThreadInferenceElapsedTime);
    }

    // }
  }

  Future<bool> getReady(
      int memberId, String exerciseName, int exerciseCount) async {
    final url = Uri.parse('http://34.64.89.205:5000/3/start');
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

  Future<bool> sendImage(CameraImage cameraImage) async {
    try {
      const url = 'http://34.64.89.205:5000/frame';

      // CameraImage의 플레인들을 연결하여 하나의 바이트 리스트로 변환
      List<int> bytes = _concatenatePlanes(cameraImage.planes);

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

      // 응답 상태코드 확인
      if (response.statusCode == 200) {
        String result = response.data.toString();
        print(result);
        return false;
      } else {
        print('Failed to send image. Status code: ${response.statusCode}');
        return true;
      }
    } catch (e) {
      print('Error sending image: $e');
      return true;
    }
  }

// CameraImage의 플레인들을 연결하여 하나의 바이트 리스트로 반환하는 함수
  List<int> _concatenatePlanes(List<Plane> planes) {
    List<int> bytes = <int>[];
    for (var plane in planes) {
      bytes.addAll(plane.bytes);
    }
    return bytes;
  }

  // // 다른 Isolate에서 추론을 실행
  // Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
  //   ReceivePort responsePort = ReceivePort();
  //   isolateUtils?.sendPort
  //       ?.send(isolateData..responsePort = responsePort.sendPort);
  //   var results = await responsePort.first;
  //   return results;
  // }

  @override
  // 앱이 일시 중지되거나 재개될 때 호출
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      // 앱이 일시 중지되면 카메라 컨트롤러의 이미지 스트림 중지
      case AppLifecycleState.paused:
        cameraController?.stopImageStream();
        break;
      // 앱이 재개되면 카메라 컨트롤러의 이미지 스트림을 다시 시작
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController?.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  // 앱이 화면에서 사라질 때 호출
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }
}
