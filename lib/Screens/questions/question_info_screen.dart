import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quizzit/Screens/questions/component/QuestionInfo.dart';
import 'package:quizzit/Screens/questions/question_screen.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/models/questions/Question.dart';
import 'package:quizzit/models/questions/QuestionCreate.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

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
              bool invalidAnswer = widget.question.answers
                  .any((element) => element.content.length == 0);
              if (widget.question.content.length != 0 && !invalidAnswer) {
                EasyLoading.show(
                    status: 'Đang thực hiện...',
                    maskType: EasyLoadingMaskType.black);
                widget.isNew
                    ? await widget
                        .createQuestion(widget.question, widget.group.id)
                        .then((value) {
                        widget.isErr = false;
                        showSuccess(text: "Tạo thành công", context: context);
                      }).catchError((onError) {
                        showError(
                            text: (onError as ProblemDetails).title!,
                            context: context);
                        widget.isErr = true;
                      })
                    : await widget
                        .updateQuestion(widget.question)
                        .then((value) => showSuccess(
                            text: "Cập nhật thành công", context: context))
                        .catchError((onError) => showError(
                            text: (onError as ProblemDetails).title!,
                            context: context));
                EasyLoading.dismiss();
                if (widget.isNew && !widget.isErr) {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(widget.group),
                    ),
                  );
                }
              } else if (invalidAnswer) {
                showError(text: "Đáp án phải có nội dung", context: context);
              } else {
                showError(text: "Câu hỏi phải có nội dung", context: context);
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
