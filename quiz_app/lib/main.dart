import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/Welcome_Screen.dart';
import 'package:quiz_app/screens/result_screen/result_screen.dart';
import 'package:quiz_app/util/bindins_app.dart';

import 'screens/quiz_screen/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'Flutter Quiz App',
      home:  const WelcomeScreen(),
      getPages: [
         GetPage(name: WelcomeScreen.routeName, page: () => const WelcomeScreen()),
         GetPage(name: QuizScreen.routeName, page: () =>  const QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () =>  const ResultScreen()),
      ],
    );
  }
}