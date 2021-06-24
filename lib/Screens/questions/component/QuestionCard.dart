import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/body.dart';
import 'package:flutter_auth/models/questions/Question.dart';

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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 10,
                              bottom: 0,
                            ),
                            child: Text(
                              question.content,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Column(
                              children: <Widget>[
                                // ignore: sdk_version_ui_as_code
                                ...List.generate(
                                    question.answers.length,
                                    (index) => Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Tag(
                                                  text: question
                                                      .answers[index].content),
                                            ),
                                          ],
                                        )),
                                // ContinueTag()
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
