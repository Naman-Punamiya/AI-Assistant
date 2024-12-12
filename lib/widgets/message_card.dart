import 'package:ai_app/global.dart';
import 'package:ai_app/main.dart';
import 'package:ai_app/models/message.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.msgType == MessageType.bot
        ? Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                child: Image.asset(
                  "images/ai.png",
                  width: 26,
                ),
              ),
              Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                      bottom: mq.height * .02, left: mq.width * .02),
                  padding: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .02),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).textColor),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: message.msg.isEmpty ? AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Please wait...',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                  ) : Text(message.msg),
                )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6),
                  margin: EdgeInsets.only(
                      bottom: mq.height * .02, right: mq.width * .02),
                  padding: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .02),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).textColor),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Text(
                    message.msg,
                    textAlign: TextAlign.left,
                  )),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          );
  }
}
