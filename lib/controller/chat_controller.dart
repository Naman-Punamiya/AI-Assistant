import 'package:ai_app/apis/apis.dart';
import 'package:ai_app/models/message.dart';
import 'package:ai_app/models/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final textC = TextEditingController();

  final scrollC = ScrollController();

  final list = <Message>[
    Message(msg: "Hello, How can I help you?", msgType: MessageType.bot)
  ].obs;

  Future<void> askQuestion() async {
    if (textC.text.trim().isNotEmpty) {
      list.add(Message(msg: textC.text, msgType: MessageType.user));
      list.add(Message(msg: '', msgType: MessageType.bot));
      _scrollDown();

      final res = await apis.getAnswer(textC.text);

      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));
      _scrollDown();

      textC.text = '';
    } else {
      MyDialog.info('Please write something in the Textfield');
    }
  }

  void _scrollDown() {
    scrollC.animateTo(scrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }
}
