import 'package:ai_app/screens/chatbot.dart';
import 'package:ai_app/screens/image_creator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

enum HomeType {aiChatbot, aiImage}

extension myHomeType on HomeType{

  String get title => switch(this){
    HomeType.aiChatbot => 'AI Chatbot',
    HomeType.aiImage => 'AI Image Generator',
  };

  String get lottie => switch(this){
    HomeType.aiChatbot => 'MobileChat',
    HomeType.aiImage => 'TextToImage',
  };

  bool get leftAlign => switch(this){
    HomeType.aiChatbot => true,
    HomeType.aiImage => false,
  };

  EdgeInsets get padding => switch(this){
    HomeType.aiChatbot => const EdgeInsets.all(12),
    HomeType.aiImage => EdgeInsets.zero,
  };

  VoidCallback get onTap => switch(this){
    HomeType.aiChatbot => () => Get.to(() => const ChatBot()),
    HomeType.aiImage => () => Get.to(() => const ImageCreator()),
  };

}