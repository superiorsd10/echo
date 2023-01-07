import 'dart:convert';

import 'package:echo/features/talk/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../api_key.dart';

class APIServices {
  static String baseUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey",
  };

  static sendMessage(String message, BuildContext context) async {
    http.Response res = await http.post(
      Uri.parse(baseUrl),
      headers: header,
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": message,
        "temperature": 0,
        "max_tokens": 100,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": [" Human:", " AI:"]
      }),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];

      print(msg);

      return msg;
    } else {
      print(res.statusCode);
      showSnackBar(message: "Failed to fetch data!", context: context);
    }
  }
}
