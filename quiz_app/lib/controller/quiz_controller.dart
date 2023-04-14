import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/question-model.dart';

import 'package:quiz_app/screens/welcome_screen.dart';

import '../screens/result_screen/result_screen.dart';

class QuizController extends GetxController{
  String name = '';
 //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
          "Ambient temperature outside of the device. ",
      answer: 2,
      options: ['Gravity', ' GPS', 'Thermometer', 'Proximity '],
    ),
     QuestionModel(
      id: 2,
      question: "Measures the rate of rotation (angular speed) around an axis ",
      answer: 2,
      options: ['GPS', 'Gravity', 'Gyroscope', 'None'],
    ),
    QuestionModel(
      id: 3,
      question: "Measure various environmental parameters",
      answer: 1,
      options: ['Motion sensors', 'Environmental sensors', 'Position sensors', 'All'],
    ),
    QuestionModel(
      id: 4,
      question: "Measure acceleration forces and rotational forces along three axes",
      answer: 0,
      options: ['Motion sensors', 'Environmental sensors', 'Position sensors', 'All'],
    ),
    QuestionModel(
      id: 5,
      question:
          "a transducer that converts a physical phenomenon into an electric signal.",
      answer: 1,
      options: ['Transducer', 'Sensor', 'Actuator', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Apache Cordova use for building Cross platform Apps ",
      answer: 3,
      options: ['HTML5', 'CSS3', 'Javascript', ' All'],
    ),
    QuestionModel(
      id: 7,
      question: "Xamarin powerful cross platform for mobile app development based on",
      answer: 3,
      options: ['Python', 'Java Script', 'C++', 'C#'],
    ),
    QuestionModel(
      id: 8,
      question: "Use standard web technologies such as HTML 5, CSS 3 & JavaScript.",
      answer: 2,
      options: ['CROSS-COMPILATION', 'V.M Approach', 'Mobile Web Apps', 'Hybrid Mobile App'],
    ),
    QuestionModel(
      id: 9,
      question:
      "One of java script framework created by Facebook. ",
      answer: 3,
      options: ['Flutter', 'Xamarin', 'Native Script', 'React Native'],
    ),
    QuestionModel(
      id: 10,
      question: "The programming language used to create App in iOS ",
      answer: 1,
      options: ['Xcode', 'Swift', '. Dart', 'Python'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];


  bool _isPressed = false;


  bool get isPressed => _isPressed; //To check if the answer is pressed


  double _numberOfQuestion = 1;


  double get numberOfQuestion => _numberOfQuestion;


  int? _selectAnswer;


  int? get selectAnswer => _selectAnswer;


  int? _correctAnswer;


  int _countOfCorrectAnswers = 0;


  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};


  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;


  final maxSec = 15;


  final RxInt _sec = 15.obs;


  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}