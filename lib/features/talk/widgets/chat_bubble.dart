import 'package:echo/constants/global_variables.dart';
import 'package:echo/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String chatText;
  final ChatMessageType type;

  const ChatBubble({Key? key, required this.chatText, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type == ChatMessageType.user
            ? GlobalVariables.backgroundColor
            : GlobalVariables.botBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: type == ChatMessageType.user
                  ? GlobalVariables.botBackgroundColor
                  : GlobalVariables.backgroundColor,
              child: type == ChatMessageType.user
                  ? const Icon(
                      Icons.person,
                      color: GlobalVariables.userTextColor,
                    )
                  : Image.asset('assets/images/echo_logo.png', width: 40, height: 40,)
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: type == ChatMessageType.user
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.botBackgroundColor,
                ),
                child: Text(
                  chatText,
                  style: TextStyle(
                    fontSize: 18,
                    color: type == ChatMessageType.user
                        ? GlobalVariables.userTextColor
                        : GlobalVariables.botTextColor,
                    fontFamily: 'SSPRegular',
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
