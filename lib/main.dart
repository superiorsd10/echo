import 'package:echo/constants/global_variables.dart';
import 'package:echo/features/home/screens/home_screen.dart';
import 'package:echo/features/talk/screens/talk_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/talk/services/text_to_speech.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TextToSpeech.initTTS();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: GlobalVariables.backgroundColor, // navigation bar color
    statusBarColor: GlobalVariables.backgroundColor, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}