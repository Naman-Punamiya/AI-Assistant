import 'package:ai_app/global.dart';
import 'package:ai_app/models/onboard.dart';
import 'package:ai_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final pageController = PageController();

    final list = [
      Onboard(
          title: "Ask Me Anything",
          subtitle:
              "I can be your bestfriend you can ask me about any topic, queries or suggestion and i will try to answer it",
          lottie: "MobileChat"),
      Onboard(
          title: "Text To Images",
          subtitle:
              "I can create images from your imagination ,after you give me a prompt i can generate image from it.",
          lottie: "TextToImage")
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.amber.shade200,
            child: Column(
              children: [
                Lottie.asset('images/${list[index].lottie}.json',
                    height: mq.height * 0.6),
                Text(
                  list[index].title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5),
                ),
                SizedBox(
                  height: mq.height * 0.1,
                ),
                SizedBox(
                  width: mq.width * 0.7,
                  child: Text(
                    list[index].subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13.5,
                        letterSpacing: 1.5),
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 10,
                  children: List.generate(
                      list.length,
                      (i) => Container(
                            width: i == index ? 15 : 10,
                            height: 8,
                            decoration: BoxDecoration(
                                color: i == index ? Colors.blue : Colors.grey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                          )),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if(index == list.length - 1){
                      Get.off(() => const HomeScreen());
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
                    }else{
                      pageController.nextPage(duration: const Duration(microseconds: 600),curve: Curves.easeInOut);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      elevation: 0,
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      minimumSize:
                          Size(mq.width * 0.4, 50)),
                  child: Text(index == list.length - 1 ? "Finish" : "Next"),
                ),
                const Spacer()
              ],
            ),
          );
        },
      ),
    );
  }
}
