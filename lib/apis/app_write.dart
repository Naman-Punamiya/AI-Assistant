import 'dart:developer';

import 'package:ai_app/global.dart';
import 'package:appwrite/appwrite.dart';

class AppWrite {
  static final _client = Client();
  static final _database = Databases(_client);
  static void init() {
    _client.setProject('675ad8d10038fc91313d').setSelfSigned(status: true);
    getGoogleApiKey();
    getTextToImageApiKey();
  }

  static Future<String> getGoogleApiKey() async {
    try {
      final d = await _database.getDocument(
          databaseId: 'MyDataBase',
          collectionId: 'ApiKey',
          documentId: 'GoogleApi');

      log(d.data['apiKey']);
      goggleapikey = d.data['apiKey'];
      return goggleapikey;

    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  static Future<String> getTextToImageApiKey() async {
    try {
      final d = await _database.getDocument(
          databaseId: 'MyDataBase',
          collectionId: 'ApiKey',
          documentId: 'TextToImage');

      log(d.data['apiKey']);
      textToImageApiKey = d.data['apiKey'];
      return textToImageApiKey;

    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}
