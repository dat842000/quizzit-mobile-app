import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/RecordScreen.dart';
import 'package:flutter_auth/Screens/quiz/constants.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/question/result/AnswerResult.dart';
import 'package:flutter_auth/models/question/result/ResultWrapper.dart'
    as Model;
import 'package:flutter_auth/models/question/submit/QuestionInfo.dart';
import 'package:flutter_auth/models/question/submit/QuestionSubmit.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'choice.dart';

class SummaryResult extends StatefulWidget {
  final Group group;

  SummaryResult(this.group);

  @override
  _SummaryResultState createState() => _SummaryResultState(group);

  Future submit(
      BuildContext context, QuestionInfo questionInfo, int quizId) async {
    log(questionInfo.toJson().toString());
    print(Host.submitQuiz(quizId: quizId));
    var response = await fetch(Host.submitQuiz(quizId: quizId), HttpMethod.PUT,
        data: questionInfo);
    if (response.statusCode.isOk()) {
      var jsonRes = json.decode(response.body);
      int numberOfCorrectAnswer = Model.ResultWrapper<AnswerResult>.fromJson(
              jsonRes, AnswerResult.fromJsonModel)
          .numberOfCorrectAnswer;
      int numberOfQuestion = Model.ResultWrapper<AnswerResult>.fromJson(
              jsonRes, AnswerResult.fromJsonModel)
          .numberOfQuestion;
      showOkAlert(context, "Submit Success", "",
          onPressed: (con) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => RecordScreen(
                    group, numberOfCorrectAnswer, numberOfQuestion),
              ),
              ModalRoute.withName("/Groups/${group.id}")));
    } else {
      print(response.body);
    }
  }
}

class _SummaryResultState extends State<SummaryResult> {
  final Group group;
  QuestionInfo questionInfo = QuestionInfo.empty();

  set numberOfQuestion(int value) => this.questionInfo.numberOfQuestion = value;

  set userAnswers(List<QuestionSubmit> value) =>
      this.questionInfo.userAnswers = value;

  _SummaryResultState(this.group);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 50,
              // ),
              Text(
                "Submit Review",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: kBlackColor),
              ),
              ...List.generate(
                _questionController.listQuestions.length,
                (index) => Choice(
                  questionIndex: index,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 130,
                height: 40,
                child: FlatButton(
                    onPressed: () async {
                      numberOfQuestion =
                          _questionController.listQuestions.length;
                      userAnswers = _questionController.listQuestionSubmit;
                      await widget.submit(
                          context, questionInfo, _questionController.id);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => SummaryResult(groupId),
                      // ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    textColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.green,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10))),
              )
            ],
          ),
        ));
  }
}
