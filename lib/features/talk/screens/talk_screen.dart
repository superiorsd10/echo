import 'package:avatar_glow/avatar_glow.dart';
import 'package:echo/constants/global_variables.dart';
import 'package:echo/features/talk/widgets/app_bar.dart';
import 'package:echo/features/talk/widgets/chat_bubble.dart';
import 'package:echo/features/talk/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../models/chat_model.dart';
import '../services/api.dart';
import '../services/text_to_speech.dart';

class TalkScreen extends StatefulWidget {
  const TalkScreen({super.key});

  @override
  State<TalkScreen> createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  bool isListening = false;
  final _formkey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  String text = "Hello";

  SpeechToText speechToText = SpeechToText();

  final List<ChatMessage> messages = [];

  ScrollController scrollController = ScrollController();

  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  clearText() {
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: EchoAppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: GlobalVariables.backgroundColor,
                ),
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var chat = messages[index];
                    return ChatBubble(
                      chatText: chat.text,
                      type: chat.type,
                    );
                  },
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: width / 1.24,
                      height: height / 14,
                      decoration: BoxDecoration(
                        color: GlobalVariables.botBackgroundColor,
                        border: Border.all(
                          color: GlobalVariables.backgroundColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            width: width / 1.5,
                            height: height / 8,
                            child: TextFormField(
                              autofocus: false,
                              controller: textController,
                              onChanged: ((value) {
                                text = value;
                              }),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  showSnackBar(
                                      message: 'Please enter text!',
                                      context: context);
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SSPSemiBold',
                                color: GlobalVariables.userTextColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  text = textController.text.trim();
                                });

                                if (text.isNotEmpty) {
                                  messages.add(
                                    ChatMessage(
                                        text: text, type: ChatMessageType.user),
                                  );

                                  String msg = await APIServices.sendMessage(
                                      text, context);
                                  msg = msg.trim();

                                  setState(() {
                                    messages.add(
                                      ChatMessage(
                                          text: msg, type: ChatMessageType.bot),
                                    );
                                  });

                                  Future.delayed(
                                      const Duration(
                                        milliseconds: 500,
                                      ), () {
                                    TextToSpeech.speak(msg);
                                  });
                                } else {
                                  showSnackBar(
                                    message: 'Failed to process. Try Again!',
                                    context: context,
                                  );
                                }

                                clearText();
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: GlobalVariables.userTextColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    AvatarGlow(
                      endRadius: 25,
                      animate: isListening,
                      duration: const Duration(milliseconds: 2000),
                      glowColor: GlobalVariables.buttonBackgroundColor,
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      showTwoGlows: true,
                      child: GestureDetector(
                        onTapDown: (details) async {
                          if (!isListening) {
                            bool available = await speechToText.initialize();

                            if (available) {
                              setState(() {
                                isListening = true;
                                speechToText.listen(
                                  onResult: (result) {
                                    setState(() {
                                      text = result.recognizedWords;
                                    });
                                  },
                                );
                              });
                            }
                          }
                        },
                        onTapUp: (details) async {
                          setState(() {
                            isListening = false;
                          });
                          await speechToText.stop();

                          if (text.isNotEmpty) {
                            messages.add(
                              ChatMessage(
                                  text: text, type: ChatMessageType.user),
                            );

                            String msg =
                                await APIServices.sendMessage(text, context);
                            msg = msg.trim();

                            setState(() {
                              messages.add(
                                ChatMessage(
                                    text: msg, type: ChatMessageType.bot),
                              );
                            });

                            Future.delayed(
                                const Duration(
                                  milliseconds: 500,
                                ), () {
                              TextToSpeech.speak(msg);
                            });
                          } else {
                            showSnackBar(
                              message: 'Failed to process. Try Again!',
                              context: context,
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              GlobalVariables.buttonBackgroundColor,
                          radius: 25,
                          child: Icon(
                            isListening ? Icons.mic : Icons.mic_none,
                            color: GlobalVariables.userTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
