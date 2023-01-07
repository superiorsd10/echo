import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech{
  static FlutterTts flutterTts = FlutterTts();

  static initTTS(){
    flutterTts.setLanguage('en-US');
  }

  static speak(String text) async{
    await flutterTts.awaitSpeakCompletion(true);
    flutterTts.speak(text);
  }
}