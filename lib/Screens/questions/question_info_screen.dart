import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/questions/component/QuestionInfo.dart';
import 'package:flutter_auth/Screens/questions/question_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';

import 'package:flutter_auth/models/questions/Question.dart';
import 'package:flutter_auth/models/questions/QuestionCreate.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/snackbar.dart';


// ignore: must_be_immutable
class QuestionInfoScreen extends StatefulWidget {
  Future<Question> updateQuestion(Question question) async {
    var response = await fetch(
        Host.updateQuestion(questionId: question.id!), HttpMethod.PUT,
        data: question);

    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk())
      return Question.fromJson(jsonRes);
    else
      return Future.error(ProblemDetails.fromJson(jsonRes));
  }

  Future<Question> createQuestion(Question question, int groupId) async {
    QuestionCreate questionCreate = new QuestionCreate(
        question.content, question.inSubject, true, question.answers);
    var response = await fetch(
        Host.groupOwnerQuestion(groupId: groupId), HttpMethod.POST,
        data: questionCreate);

    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk())
      return Question.fromJson(jsonRes);
    else
      return Future.error(ProblemDetails.fromJson(jsonRes));
  }

  Question question;
  bool isNew;
  Group group;
  bool isErr = false;

  QuestionInfoScreen(this.question, this.isNew, this.group);

  @override
  _QuestionInfoScreen createState() => _QuestionInfoScreen();
}

class _QuestionInfoScreen extends State<QuestionInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: deprecated_member_use
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        leadingWidth: 75,
        actions: [
          GestureDetector(
            onTap: () async {
              widget.isNew
                  ? await widget
                      .createQuestion(widget.question, widget.group.id)
                      .then((value) {
                      widget.isErr = false;
                      showSuccess(text: "Tạo thành công", context: context);
                    }).catchError((onError) {
                      showError(text: (onError as ProblemDetails).title! , context:  context);
                      widget.isErr = true;
                    })
                  : await widget
                      .updateQuestion(widget.question)
                      .then(
                          (value) => showSuccess(text: "Cập nhật thành công", context: context))
                      .catchError((onError) => showError(text: (onError as ProblemDetails).title!, context: context));
              if (widget.isNew && !widget.isErr) {
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(widget.group),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: QuestionInfo(widget.question, widget.isNew, widget.group),
    );
  }
}
