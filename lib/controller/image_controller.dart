// import 'dart:typed_data';
// import 'package:ai_app/global.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stability_image_generation/stability_image_generation.dart';

// enum Status { none, loading, complete }

// class ImageController extends GetxController {
//   final textC = TextEditingController();
//   final status = Status.none.obs;

//   String url = "";

//   Future<Uint8List> createAIImage(String text) async {
//     Uint8List image = await _ai.generateImage(
//       apiKey: textToImageApiKey,
//       imageAIStyle: ImageAIStyle.anime,
//       prompt: textC.text,
//     );
//     return image;
//   }
//   // OpenAI.apiKey = openaiapikey;
//   // if (textC.text.trim().isNotEmpty) {
//   //   status.value = Status.loading;
//   //   OpenAIImageModel image = await OpenAI.instance.image.create(
//   //       prompt: textC.text,
//   //       n: 1,
//   //       size: OpenAIImageSize.size512,
//   //       responseFormat: OpenAIImageResponseFormat.url);
//   //   url = image.data[0].url.toString();

//   //   textC.text = '';
//   //   status.value = Status.complete;
//   // }
// }

import 'dart:typed_data';
import 'package:ai_app/apis/apis.dart';
import 'package:ai_app/global.dart';
import 'package:ai_app/models/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class ImageController extends GetxController {
  var textC = TextEditingController();
  final StabilityAI _ai = StabilityAI();
  var status = Status.none.obs;
  var generatedImage =
      Rx<Uint8List?>(null); // Reactive variable for the image data

  final url = ''.obs;

  final imageList = <String>[].obs;

  Future<void> createAIImage(String prompt) async {
    if (textC.text.isNotEmpty) {
      try {
        status.value = Status.loading; // Set status to loading
        // Call your image generation function here
        Uint8List image = await _ai.generateImage(
          apiKey: textToImageApiKey,
          imageAIStyle: ImageAIStyle.anime,
          prompt: prompt,
        );
        generatedImage.value = image; // Store the generated image
        status.value = Status.complete; // Set status to complete
      } catch (e) {
        MyDialog.error(e.toString()); // Store error message
        status.value = Status.error; // Set status to error
      }
    } else {
      MyDialog.info('Provide Some Description');
    }
  }

  Future<void> searchAIImage() async {
    if(textC.text.trim().isNotEmpty){
      status.value = Status.loading;
      imageList.value = await apis.searchAIImages(textC.text);
    
      if(imageList.isEmpty){
        MyDialog.error('Something went wrong. Try again later');
        return;
      }

      url.value = imageList.first;

      status.value = Status.complete;
    }else{
      MyDialog.info('Provide Some Description');
      status.value = Status.none;
    }
  }

}

enum Status { none, loading, complete, error }
