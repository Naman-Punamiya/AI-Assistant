import 'package:ai_app/global.dart';
import 'package:ai_app/models/pref.dart';
import 'package:ai_app/screens/home_screen.dart';
import 'package:ai_app/screens/onboarding_screen.dart';
import 'package:ai_app/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (_) => Pref.showOnboarding
      //         ? const OnboardingScreen()
      //         : const HomeScreen()));
      Get.off(() =>
          Pref.showOnboarding ? const OnboardingScreen() : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Spacer(flex: 3),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Hello Everyone",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            CustomLoading(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
