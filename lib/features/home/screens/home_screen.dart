import 'package:echo/constants/global_variables.dart';
import 'package:echo/features/home/widgets/lets_talk_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height / 6,
                ),
                Image.asset(
                  'assets/images/echo_logo.png',
                  width: width / 1.3,
                ),
                SizedBox(
                  height: height / 20,
                ),
                const LetsTalkButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
