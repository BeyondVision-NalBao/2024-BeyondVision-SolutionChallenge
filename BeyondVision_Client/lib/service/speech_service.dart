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
    await speechText.listen(onResult: _onSpeechResult, localeId: 'ko_KR');
  }

  Future<void> stopListening() async {
    await speechText.stop();
  }

  void speakResult() {}
}
