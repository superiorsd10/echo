import 'package:echo/features/talk/screens/talk_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class LetsTalkButton extends StatelessWidget {
  const LetsTalkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TalkScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalVariables.buttonBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 6,
        ),
      ),
      child: const Text(
        'Let\'s Talk',
        style: TextStyle(
          fontFamily: 'SSPSemiBold',
          fontSize: 24,
          color: GlobalVariables.userTextColor,
        ),
      ),
    );
  }
}
