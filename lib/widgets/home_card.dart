import 'package:ai_app/global.dart';
import 'package:ai_app/models/home_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;

  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(.2),
      elevation: 0,
      margin: EdgeInsets.only(bottom: mq.height * .02),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: homeType.onTap,
        child: homeType.leftAlign
            ? Row(
                children: [
                  Container(
                    padding: homeType.padding,
                    width: mq.width * .35,
                    child: Lottie.asset("images/${homeType.lottie}.json"),
                  ),
                  const Spacer(),
                  Text(
                    homeType.title,
                    style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              )
            : Row(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    homeType.title,
                    style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    padding: homeType.padding,
                    width: mq.width * .35,
                    child: Lottie.asset("images/${homeType.lottie}.json"),
                  ),
                ],
              ),
      ),
    ).animate().fade(duration: 1.5.seconds, curve: Curves.easeInOut);
  }
}
