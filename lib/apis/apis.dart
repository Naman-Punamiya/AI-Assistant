import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ai_app/global.dart';
import 'package:ai_app/models/my_dialog.dart';
import 'package:http/http.dart';

class apis {
  static Future<String> getAnswer(String Question) async {
    try {
      final res = await post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$goggleapikey'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.authorizationHeader: 'Bearer $goggleapikey'
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                // {"maxNumberOfTokens": 1000,},
                // "temperature": 0,
                {"text": Question}
              ]
            }
          ]
        }),
      );

      final data = jsonDecode(res.body);
      // print('res : $data');
      return data['candidates'][0]['content']['parts'][0]['text'];
    } catch (e) {
      // print(e);
      MyDialog.error('Something went wrong. Try again Later');
      print(e.toString());
      return 'Something went wrong. Try again Later';
    }
  }

  static Future<List<String>> searchAIImages(String prompt) async {
    try {
      final res =
          await get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      final data = jsonDecode(res.body);

      return List.from(data['images']).map((e) => e['src'].toString()).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
