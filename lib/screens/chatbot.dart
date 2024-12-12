import 'package:ai_app/controller/chat_controller.dart';
import 'package:ai_app/global.dart';
import 'package:ai_app/models/pref.dart';
import 'package:ai_app/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final _c = ChatController();
  final SpeechToText speechToTextInstance = SpeechToText();
  String recordedAudioString = "";
  bool isLoading = false;

  void initializeSpeechToText() async {
    await speechToTextInstance.initialize();

    setState(() {});
  }

  void startListeningNow() async {
    FocusScope.of(context).unfocus();
    await speechToTextInstance.listen(onResult: onSpeechToTextResult);
    setState(() {});
  }

  void stopListeningNow() async {
    await speechToTextInstance.stop();
    setState(() {});
  }

  void onSpeechToTextResult(SpeechRecognitionResult recognitionResult) {
    recordedAudioString = recognitionResult.recognizedWords;
    // print(recordedAudioString);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
    initializeSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "images/Logo.png",
            width: 250,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.center,
                onTapOutside: (e) => FocusScope.of(context).unfocus,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    hintText: "Ask me anything you want...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              )),
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 24,
                child: IconButton(
                    onPressed: _c.askQuestion,
                    icon: const Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.white,
                      size: 28,
                    )),
              )
            ],
          ),
        ),
        body: Obx(
          () => ListView(
            physics: const BouncingScrollPhysics(),
            controller: _c.scrollC,
            padding: EdgeInsets.only(top: mq.height * .02, bottom: mq.height *.01),
            children: _c.list.map((e) => MessageCard(message: e)).toList(),
          ),
        )

        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Column(
        //       children: [
        //         const SizedBox(
        //           height: 30,
        //         ),
        //         Center(
        //           child: InkWell(
        //             onTap: () {
        //               speechToTextInstance.isListening
        //                   ? stopListeningNow()
        //                   : startListeningNow();
        //             },
        //             child: speechToTextInstance.isListening
        //                 ? Center(
        //                     child: LoadingAnimationWidget.beat(
        //                         color: speechToTextInstance.isListening
        //                             ? Colors.blue
        //                             : isLoading
        //                                 ? Colors.blue.shade100
        //                                 : Colors.blue.shade700,
        //                         size: 300))
        //                 : Image.asset(
        //                     'images/microphone.png',
        //                     width: 300,
        //                   ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 50,
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //                 child: Padding(
        //               padding: const EdgeInsets.only(left: 4),
        //               child: TextField(
        //                 controller: userInput,
        //                 decoration: const InputDecoration(
        //                   border: OutlineInputBorder(),
        //                   labelText: "How can i help you ?",
        //                 ),
        //               ),
        //             )),
        //             const SizedBox(
        //               width: 10,
        //             ),
        //             InkWell(
        //               onTap: () {
        //                 // print("Hello");
        //               },
        //               child: AnimatedContainer(
        //                 duration: const Duration(milliseconds: 1000),
        //                 curve: Curves.bounceInOut,
        //                 padding: const EdgeInsets.all(14),
        //                 decoration: const BoxDecoration(
        //                     borderRadius: BorderRadius.all(Radius.circular(8)),
        //                     shape: BoxShape.rectangle,
        //                     color: Colors.blue),
        //                 child: const Icon(
        //                   Icons.arrow_forward_rounded,
        //                   color: Colors.white,
        //                   size: 30,
        //                 ),
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
