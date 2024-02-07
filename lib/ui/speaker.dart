import 'package:beyond_vision/core/core.dart';
import 'package:beyond_vision/service/speech_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Speaker extends StatefulWidget {
  const Speaker({super.key});

  @override
  State<Speaker> createState() => _SpeakerState();
}

class _SpeakerState extends State<Speaker> {
  final FlutterTts tts = FlutterTts();
  late SpeechToText _speechToText;
  late StsService _speech;
  bool isListening = false;
  int isResult = 1;

  @override
  void initState() {
    // TODO: implement initState
    _speechToText = SpeechToText();
    _speech = StsService(_speechToText);
    _speech.initSpeech(_speechToText);
    tts.setSpeechRate(0.4);
    tts.setPitch(1.0);
    tts.speak("무엇을 하고 싶으신가요?");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color(boxColor),
                    borderRadius: BorderRadius.circular(30)),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "무엇을 하고\n싶으신가요?",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(fontYellowColor),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: const Size(50, 50), // 원하는 크기로 조절
              painter: InvertedTrianglePainter(),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 360,
              child: isResult == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_box("이동"), _box("설명")],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_box("운동 하기"), _box("운동 루틴")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_box("운동 기록"), _box("앱 설정")],
                        )
                      ],
                    ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(boxColor),
              child: IconButton(
                onPressed: () {
                  // 상태 변경 및 setState() 호출
                  setState(() {
                    if (isListening) {
                      _speech.stopListening().then((value) => {
                            if (value == "이동")
                              {isResult = 5, tts.speak("어느 페이지로 이동할까요?")}
                            else if (value == "설명")
                              {}
                            else if (value == "운동 하기")
                              {}
                            else if (value == "운동 기록")
                              {}
                            else if (value == "운동 루틴")
                              {}
                            else if (value == "앱 설정")
                              {}
                            else
                              {tts.speak("이동과 설명 중 하나를 말씀해주세요")}
                          });
                    } else {
                      _speech.startListening();
                    }
                    if (isResult == 5) isResult == 2;
                    isListening = !isListening;
                  });
                },
                tooltip: 'Listen',
                icon: Icon(
                  // 상태에 따라 아이콘 변경
                  isListening ? Icons.stop : Icons.mic,
                  size: 50,
                  color: const Color(fontYellowColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? '듣는 중'
                    : _speech.speechEnabled
                        ? ' '
                        : '마이크를 사용할 수 없습니다.',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ));
  }

  Widget _box(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: const Color(boxColor),
            borderRadius: BorderRadius.circular(30),
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(boxColor)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // 왼쪽 하단
    path.lineTo(size.width, 0); // 상단 중앙
    path.lineTo(size.width / 2, size.height); // 오른쪽 하단
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
