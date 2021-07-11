import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizzit/Screens/questions/question_info_screen.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/global/Subject.dart' as subject;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/models/questions/Question.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

// ignore: must_be_immutable
class QuestionCard extends StatefulWidget {
  Future deleteQuestionFromGroup(
      {required int questionId, required int groupId}) async {
    var response = await fetch(
        Host.groupOwnerUpdateAddQuestion(
            groupId: groupId, questionId: questionId),
        HttpMethod.DELETE);
    if (response.statusCode.isOk())
      question.isAdd = false;
    else
      return Future.error(ProblemDetails.fromJson(json.decode(response.body)));
  }

  Future addQuestionToGroup(
      {required int questionId, required int groupId}) async {
    var response = await fetch(
        Host.groupOwnerUpdateAddQuestion(
            groupId: groupId, questionId: questionId),
        HttpMethod.PUT);
    if (response.statusCode.isOk())
      question.isAdd = true;
    else
      return Future.error(ProblemDetails.fromJson(json.decode(response.body)));
  }

  Question question;
  final Group group;

  QuestionCard(this.question, this.group);

  @override
  _QuestionCard createState() => _QuestionCard(question);
}

class _QuestionCard extends State<QuestionCard> {
  Question question;

  _QuestionCard(this.question);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          // isLast ? const EdgeInsets.only(bottom: 45) : const EdgeInsets.only(),
          const EdgeInsets.only(),
      child: Center(
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      QuestionInfoScreen(question, false, widget.group),
                ));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 38,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 2)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 85,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 40,
                                bottom: 0,
                              ),
                              child: Text(
                                question.content,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 3,
                                bottom: 7,
                              ),
                              child: int.parse(FirebaseAuth
                                          .instance.currentUser!.uid) ==
                                      question.createdBy!.id
                                  ? Text(
                                      "Tạo bởi bạn",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(
                                      "Tạo bởi : ${question.createdBy!.fullName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Text(
                              "Thay đổi lần cuối : ${DateFormat('dd/MM/yyyy').format(question.updateAt!)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // ignore: deprecated_member_use
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 6,
                        right: 8,
                        width: 83,
                        child:
                            // ignore: deprecated_member_use
                            question.isAdd!
                                // ignore: deprecated_member_use
                                ? TextButton(
                                    onPressed: () {
                                      widget
                                          .deleteQuestionFromGroup(
                                              questionId: question.id!,
                                              groupId: widget.group.id)
                                          .then((value) {
                                        setState(() {});
                                        showSuccess(
                                            text: "Xóa khỏi group thành công",
                                            context: context);
                                      }).catchError((onError) {
                                        showError(
                                            text: (onError as ProblemDetails)
                                                .title!,
                                            context: context);
                                      });
                                    },
                                    // color: Colors.redAccent,
                                    style: ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.redAccent),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              kPrimaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.clear,
                                          color: Colors.grey[200],
                                          size: 13.5,
                                        ),
                                        SizedBox(
                                          width: 1.5,
                                        ),
                                        Text(
                                          "Remove",
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[100]),
                                        ),
                                      ],
                                    ),
                                  )
                                :
                                // ignore: deprecated_member_use
                                FlatButton(
                                    onPressed: () {
                                      widget
                                          .addQuestionToGroup(
                                              questionId: question.id!,
                                              groupId: widget.group.id)
                                          .then((value) {
                                        setState(() {});
                                        showSuccess(
                                            text: "Thêm vào group thành công",
                                            context: context);
                                      }).catchError((onError) {
                                        showError(
                                            text: (onError as ProblemDetails)
                                                .title!,
                                            context: context);
                                      });
                                    },
                                    color: Color(0xFF3AA35C),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.grey[200],
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "Add",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[100]),
                                        ),
                                      ],
                                    ),
                                    textColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xFF3AA35C),
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Text(
                        subject.subjects
                            .firstWhere(
                                (element) => element.id == question.inSubject)
                            .name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Row(children: [
                        Icon(
                          question.isPrivate!
                              ? CupertinoIcons.lock
                              : CupertinoIcons.globe,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
