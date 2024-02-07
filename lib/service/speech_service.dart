import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class StsService {
  late SpeechToText speechText;
  String _lastWords = "";
  bool speechEnabled = true;

  String get lastWords => _lastWords;
  String result = "";
  StsService(SpeechToText speechToText) {
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

  Future<String> stopListening() async {
    await speechText.stop().then((value) => {
          if (lastWords.contains("이동"))
            {result = "이동"}
          else if (lastWords.contains("설명"))
            {result = "설명"}
          else if (lastWords.contains("하기"))
            {result = "운동 하기"}
          else if (lastWords.contains("기록"))
            {result = "운동 기록"}
          else if (lastWords.contains("루틴"))
            {result = "운동 루틴"}
          else if (lastWords.contains("설정"))
            {result = "앱 설정"}
          else
            {result = "이동과 설명 중 하나를 말씀해주세요"}
        });
    return result;
  }

  void speakResult() {}
}
