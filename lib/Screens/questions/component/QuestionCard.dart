import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/global/Subject.dart' as subject;
import 'package:flutter_auth/models/questions/Question.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class QuestionCard extends StatelessWidget {
  Question question;

  QuestionCard(this.question);

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
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 2)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
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
                                question.content.length > 70
                                    ? "${question.content.substring(0, 73)}..."
                                    : question.content,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
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
                            child:
                            int.parse(FirebaseAuth.instance.currentUser!.uid) == question.createdBy.id ?
                            Text(
                              "Tạo bởi bạn",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ) :
                            Text(
                              "Tạo bởi : ${question.createdBy.fullName}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Text(
                              "Thay đổi lần cuối : ${DateFormat('dd/MM/yyyy').format(question.updateAt)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          question.isPrivate
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
