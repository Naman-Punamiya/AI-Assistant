// import 'dart:io';
// import 'dart:typed_data';
import 'package:ai_app/controller/image_controller.dart';
import 'package:ai_app/global.dart';
import 'package:ai_app/main.dart';
import 'package:ai_app/models/my_dialog.dart';
import 'package:ai_app/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
// import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

class ImageCreator extends StatefulWidget {
  const ImageCreator({super.key});

  @override
  State<ImageCreator> createState() => _ImageCreatorState();
}

class _ImageCreatorState extends State<ImageCreator> {
  final _c = ImageController();
  bool success = false;
  // Future<void> saveImageToGallery(Uint8List imageBytes) async {
  //   // Request permissions
  //   PermissionStatus status = await Permission.photos.request();
  //   final dir = await getTemporaryDirectory();
  //   final file =
  //       await File('${dir.path}/ai_image.png').writeAsBytes(imageBytes);

  //   if (status.isGranted) {
  //     try {
  //       CustomLoading();
  //       await GallerySaver.saveImage(file.path, albumName: appName)
  //           .then((success) {
  //         if (success != null && success) {
  //           Get.back();
  //           MyDialog.success('Image saved to gallery');
  //         } else {
  //           Get.back();
  //           MyDialog.error('Failed to save image');
  //         }
  //       });
  //       // final result =
  //       //     await ImageGallerySaver.saveImage(imageBytes, name: appName);
  //       // if (result['isSuccess']) {
  //       //   Get.back();
  //       //   MyDialog.success('Image saved to gallery');
  //     } catch (e) {
  //       Get.back();
  //       MyDialog.error('Failed to save image');
  //     }
  //   } else {
  //     MyDialog.info('Permission denied to save images');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() => _c.status.value == Status.complete
          ? Padding(
              padding: const EdgeInsets.only(right: 6, bottom: 6),
              child: FloatingActionButton(
                onPressed: () {
                  // if (_c.status.value == Status.complete &&
                  //     _c.generatedImage.value != null) {
                  //   await saveImageToGallery(_c.generatedImage.value!);
                  // } else {
                  //   MyDialog.error('No image to save');
                  // }
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Icon(
                  Icons.save_alt_rounded,
                  size: 26,
                ),
              ),
            )
          : SizedBox()),
      appBar: AppBar(
        title: const Text('AI Image Creator'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: mq.height * .02,
            bottom: mq.height * .01,
            left: mq.width * .04,
            right: mq.width * .04),
        children: [
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus,
            decoration: const InputDecoration(
                hintText:
                    "Imagine Something Wonderful & Innovative\nType Here & I will create an image for you 🤩",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          Container(
            height: mq.height * .5,
            alignment: Alignment.center,
            child: Obx(() => _aiImage()),
          ),
          Align(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).onButtonBg,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    minimumSize: Size(mq.width * .4, 50)),
                onPressed: () => _c.searchAIImage(),
                // _c.createAIImage(_c.textC.text),
                child: const Text("Create")),
          )
        ],
      ),
    );
  }

  // Widget _aiImage() {
  //   if (_c.status.value == Status.loading) {
  //     return const CustomLoading();
  //   } else if (_c.status.value == Status.none) {
  //     return Container(
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white30,),
  //         child: Lottie.asset("images/TextToImage.json"));
  //   } else if (_c.status.value == Status.complete) {
  //     MyDialog.success('Image Created Successfully');
  //     return ClipRRect(
  //       borderRadius: BorderRadius.circular(10),
  //       child: Image.memory(_c.generatedImage.value!),
  //     );
  //   } else {
  //     MyDialog.error('Something went wrong!!!');
  //     return Container();
  //   }
  // }

  Widget _aiImage() {
    if (_c.status.value == Status.loading) {
      return const CustomLoading();

    } else if (_c.status.value == Status.none) {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white30),
          child: Lottie.asset("images/TextToImage.json"));
    
    } else if (_c.status.value == Status.complete) {
      // MyDialog.success('Image Created Successfully');
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(_c.url.value), // Display the image from URL
      );
    
    } else {
      MyDialog.error('Something went wrong!!!');
      return Container();
    }
  
  }
}
  // ClipRRect(
  //   borderRadius: const BorderRadius.all(Radius.circular(10)),
  //   child: switch (_c.status.value) {
  //         Status.none => Lottie.asset("images/TextToImage.json"),
  //         Status.loading => const CustomLoading(),
  //         Status.complete => Image.memory()
  //         // CachedNetworkImage(
  //         //     imageUrl: _c.url,
  //         //     placeholder: (context, url) => const CustomLoading(),
  //         //     errorWidget: (context, url, error) => const SizedBox(),
  //         //   ),
  //       },
  // );