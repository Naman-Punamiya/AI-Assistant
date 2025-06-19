import 'package:ai_app/apis/app_write.dart';
import 'package:ai_app/global.dart';
import 'package:ai_app/models/pref.dart';
import 'package:ai_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Pref.initialize();

  AppWrite.init();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            // backgroundColor: Colors.white,
            // iconTheme: IconThemeData(color: Colors.blue),
            titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
      themeMode: Pref.defaultTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  Color get onBoardBg => brightness == Brightness.dark
      ? Colors.grey.shade700
      : Colors.amber.shade200;

  Color get onButtonBg => brightness == Brightness.dark
      ? Colors.cyan.shade800
      : Colors.blue;

  Color get textColor => brightness == Brightness.dark
      ? Colors.white70
      : Colors.black54;

}
