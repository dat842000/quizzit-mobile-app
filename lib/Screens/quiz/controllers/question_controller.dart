import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:quizzit/models/question/Question.dart';
import 'package:quizzit/models/question/QuestionsWrapper.dart' as Model;
import 'package:quizzit/models/question/submit/QuestionSubmit.dart';
import 'package:quizzit/utils/ApiUtils.dart';

import '../../../constants.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? _animationController;
  Animation? _animation;

  Animation? get animation => this._animation;

  PageController? _pageController;

  PageController? get pageController => this._pageController;

  late Future<Model.QuestionsWrapper<Question>> _questionFuture;
  List<Question> listQuestions = [];
  int ans = 0;
  List<QuestionSubmit> listQuestionSubmit = [];
  int id = 0;
  var groupId = 0.obs;

  // List<Question> get questions => this._questions;

  QuestionController(); // for more about obs please check documentation

  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  Future<Model.QuestionsWrapper<Question>> _fetchQuiz(int groupId) async {
    var response = await fetch(
        Host.groupQuiz(groupId: groupId), HttpMethod.POST,
        data: null);
    // log(response.body);
    // var jsonRes = json.decode(response.body);
    // print(jsonRes);
    // print(response.body);
    log(response.body);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk())
      return Model.QuestionsWrapper<Question>.fromJson(
          jsonRes, Question.fromJsonModel);
    else
      throw new Exception(response.body);
  }

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.onInit();
  }

  // void updateGroupId(var groupId) {
  //   this.groupId = groupId;
  //   fetchQuestion(this.groupId);
  // }

  void resetQuestionNumber() => _questionNumber.value = 1;

  void resetPageController() {
    _pageController = PageController();
  }

  void fetchQuestion(var groupId) {
    log("FETCH QUESTIONs");
    _questionFuture = _fetchQuiz(groupId);
    _questionFuture.then((value) {
      ans = 0;
      id = value.id;
      listQuestions = value.questions;
      listQuestionSubmit = listQuestions
          .map((question) =>
              QuestionSubmit(question.id, question.questionToken, -1))
          .toList();
      print(listQuestionSubmit.toString());
      update();
    }).catchError((error) {
      log(error.toString());
      listQuestions = [];
      listQuestionSubmit = [];
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
    ans = 0;
  }

  void saveAnswer(Question question, int answerId) {
    // print(questions.length);
    // listQuestions.firstWhere((element) => element.id == question.id).choice =
    //     selectedIndex;

    if (listQuestionSubmit
            .firstWhere((element) => element.questionId == question.id)
            .answerId ==
        -1) {
      ans++;
    }
    listQuestionSubmit
        .firstWhere((element) => element.questionId == question.id)
        .answerId = answerId;
  }

  void nextQuestion() {
    _pageController!
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
  }

  void prevQuestion() {
    _pageController!.previousPage(
        duration: Duration(milliseconds: 400), curve: Curves.ease);
  }

  void goToQuestion(int page) {
    _pageController!.animateToPage(page,
        duration: Duration(milliseconds: 400), curve: Curves.ease);
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
