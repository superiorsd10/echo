import 'package:echo/constants/global_variables.dart';
import 'package:flutter/material.dart';

class EchoAppBar extends StatelessWidget {
  const EchoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'echo',
        style: TextStyle(
          color: GlobalVariables.userTextColor,
          fontFamily: 'SSPBold',
          fontSize: 48,
        ),
      ),
      centerTitle: true,
      backgroundColor: GlobalVariables.botBackgroundColor,
      elevation: 0,
    );
  }
}
