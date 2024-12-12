import 'package:ai_app/global.dart';
import 'package:ai_app/models/home_type.dart';
import 'package:ai_app/models/pref.dart';
import 'package:ai_app/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _isDarkMode = Get.isDarkMode.obs;

  @override
  Widget build(BuildContext context) {
    // apis.getAnswer("Hii");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Assistant",
          style: TextStyle(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    _isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
                    _isDarkMode.value = !_isDarkMode.value;
                    Pref.isDarkMode = !_isDarkMode.value;
              },
              icon: Obx( () => Icon(_isDarkMode.value ? Icons.brightness_2_rounded :
                  Icons.brightness_5_rounded,
                  size: 26,
                ),
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .015),
        children: HomeType.values
            .map((e) => HomeCard(
                  homeType: e,
                ))
            .toList(),
      ),
    );
  }
}
