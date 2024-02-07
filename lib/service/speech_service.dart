import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech {
  late SpeechToText speechText;
  String _lastWords = "";
  bool speechEnabled = false;
  String notice = "설명과 이동 중 하나를 선택해주세요";

  String get lastWords => _lastWords;

  Speech(SpeechToText speechToText) {
    speechText = speechToText;
  }

  void initSpeech(SpeechToText speechText) async {
    speechEnabled = await speechText.initialize();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
  }

  void speechString(String words) {}
  void startListening() async {
    await speechText.listen(onResult: _onSpeechResult);
  }

  void stopListening() async {
    await speechText.stop().then((value) => {
          if (lastWords.contains("이동"))
            {print("이동")}
          else if (lastWords.contains("설명"))
            {print("설명")}
          else
            {print("이동 또는 설명 중에 하나를 말씀해주세요")}
        });
  }
}
