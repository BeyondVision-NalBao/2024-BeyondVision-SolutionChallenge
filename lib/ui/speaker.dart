import 'package:beyond_vision/core/core.dart';
import 'package:beyond_vision/service/speech_service.dart';
import 'package:beyond_vision/ui/record/record.dart';
import 'package:beyond_vision/ui/routine/routine.dart';
import 'package:beyond_vision/ui/setting/setting.dart';
import 'package:beyond_vision/ui/workout/workout.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Speaker extends StatefulWidget {
  final String? getString;
  const Speaker({super.key, required this.getString});

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
    tts.setPitch(0.9);
    tts.speak("무엇을 하고 싶으신가요?");
    if (isListening) {
      tts.stop();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _speechToText.cancel();
    isListening = false;
    tts.stop();
    super.dispose();
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
                  tts.stop();
                  // 상태 변경 및 setState() 호출
                  setState(() {
                    if (isListening) {
                      _speech.stopListening().then((value) => {
                            print(_speech.lastWords),
                            if (_speech.lastWords.contains("이동"))
                              {isResult = 5, tts.speak("어느 페이지로 이동할까요?")}
                            else if (_speech.lastWords.contains("설명"))
                              {
                                tts.speak(widget.getString!),
                              }
                            else if (_speech.lastWords.contains("하기"))
                              {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const WorkOut())),
                              }
                            else if (_speech.lastWords.contains("루틴"))
                              {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const RoutinePage(
                                            isWorkout: false))),
                              }
                            else if (_speech.lastWords.contains("기록"))
                              {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RecordPage())),
                              }
                            else if (_speech.lastWords.contains("설정"))
                              {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Setting())),
                              }
                            else
                              {tts.speak("이동과 설명 중 하나를 말씀해주세요")}
                          });
                    } else {
                      _speech.startListening();
                    }

                    isListening = !isListening;
                    if (isResult == 5) isResult = 2;
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
                        ? '원하는 걸 말씀해주세요'
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
