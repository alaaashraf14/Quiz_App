import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/quiz_controller.dart';
import '../../widgtes/custom_button.dart';
import '../../widgtes/progress_timer.dart';
import '../../widgtes/question_card.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   elevation: 0,
          backgroundColor: const Color.fromARGB(255, 6, 106, 96),
        // ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage('assets/images/here.jpg'),
                  //     fit: BoxFit.cover),
                  color: Colors.black87),
            ),
            SafeArea(
              child: GetBuilder<QuizController>(
                init: QuizController(),
                builder: (controller) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Question ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: controller.numberOfQuestion
                                          .round()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.white)),
                                  TextSpan(
                                      text: '/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white)),
                                  TextSpan(
                                      text: controller.countOfQuestion.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white)),
                                ]),
                          ),
                          ProgressTimer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionsList[index],
                        ),
                        controller: controller.pageController,
                        itemCount: controller.questionsList.length,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Image.asset(
                        "assets/images/shf.png",
                        height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: GetBuilder<QuizController>(
          init: QuizController(),
          builder: (controller) => CustomButton(
              onPressed: () => controller.nextQuestion(), text: 'Next'),
        ),
      
    );
  }
}