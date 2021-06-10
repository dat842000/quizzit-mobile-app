import 'package:flutter/widgets.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/quiz/models/Questions.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? _animationController;
  Animation? _animation;

  Animation? get animation => this._animation;

  PageController? _pageController;

  PageController? get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void saveAnswer(Question question, int selectedIndex) {
    print(questions.length);
    questions.firstWhere((element) => element.id == question.id).choice =
        selectedIndex;
  }

  void nextQuestion() {
    _pageController!
        .nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);
  }

  void prevQuestion() {
    _pageController!.previousPage(
        duration: Duration(milliseconds: 250), curve: Curves.ease);
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
