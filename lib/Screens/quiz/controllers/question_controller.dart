import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/PostDetail/model/comments_data.dart';
// import 'package:flutter_auth/Screens/quiz/models/Questions.dart';
// import 'package:flutter_auth/Screens/quiz/models/Questions.dart';
import 'package:flutter_auth/models/question/Question.dart';
import 'package:flutter_auth/models/question/QuestionsWrapper.dart' as Model;
import 'package:flutter_auth/models/question/submit/QuestionSubmit.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../constants.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? _animationController;
  Animation? _animation;

  Animation? get animation => this._animation;

  PageController? _pageController;

  PageController? get pageController => this._pageController;

  late Future<Model.QuestionsWrapper<Question>> _questionFuture;
  List<Question> listQuestions =[];
  List<QuestionSubmit> listQuestionSubmit = [];

  // List<Question> get questions => this._questions;

  QuestionController(); // for more about obs please check documentation

  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  Future<Model.QuestionsWrapper<Question>> _fetchQuiz(int groupId) async {
    var response = await fetch(Host.groupQuiz(groupId: groupId), HttpMethod.POST, data: null);
    // log(response.body);
    // var jsonRes = json.decode(response.body);
    // print(jsonRes);
    // print(response.body);
    var jsonRes = json.decode(response.body);
    // print(response.body);
    if (response.statusCode.isOk())
      return Model.QuestionsWrapper<Question>.fromJson(jsonRes, Question.fromJsonModel);
    else
      throw new Exception(response.body);
  }

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  void fetchQuestion(int groupId) {
    _questionFuture = _fetchQuiz(groupId);
    _questionFuture.then((value) {
      listQuestions = value.questions;
      listQuestionSubmit = listQuestions.map((question) => QuestionSubmit(question.id, question.questionToken, -1)).toList();
      // print(listQuestionSubmit.toString());
      update();
    });

    // List<Question> _questions = sample_data
    //     .map(
    //       (question) => Question(
    //           id: question['id'],
    //           question: question['question'],
    //           options: question['options'],
    //           answer: question['answer_index']),
    //     )
    //     .toList();

  }



  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void saveAnswer(Question question, int answerId) {
    // print(questions.length);
    // listQuestions.firstWhere((element) => element.id == question.id).choice =
    //     selectedIndex;

    listQuestionSubmit.firstWhere((element) => element.id == question.id).answerId = answerId;
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
