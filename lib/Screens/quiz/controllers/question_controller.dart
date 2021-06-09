import 'package:flutter/widgets.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/quiz/models/Questions.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {

  AnimationController _animationController;
  Animation _animation;

  Animation get animation => this._animation;

  PageController _pageController;

  PageController get pageController => this._pageController;

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

  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;

  int _correctAns;

  int get correctAns => this._correctAns;

  int _selectedAns;

  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  @override
  void onInit() {
    print("ok");
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void saveAnswer(Question question, int selectedIndex) {
    _isAnswered = true;
    print(questionNumber.value);
    // _correctAns = question.answer;
    questions[questionNumber.value - 1].choice = selectedIndex;
    // question.choice = selectedIndex;
    // print(questions[questionNumber.value - 1].choice);

    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

    } else {
      // Get package provide us simple way to naviigate another page
      // Get.to(LoginScreen());
    }
  }

  void prevQuestion() {
    _isAnswered = false;
    _pageController.previousPage(
        duration: Duration(milliseconds: 250), curve: Curves.ease);

  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
