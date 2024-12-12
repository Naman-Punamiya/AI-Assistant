import 'package:ai_app/global.dart';
import 'package:ai_app/models/home_type.dart';
import 'package:ai_app/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    // apis.getAnswer("Hii");

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "AI Assistant",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.brightness_4_rounded,
                color: Colors.black,
                size: 20,
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
