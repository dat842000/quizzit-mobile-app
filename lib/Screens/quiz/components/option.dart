import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quizzit/Screens/quiz/constants.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.questionIndex,
    required this.index,
    required this.answerIndex,
    required this.press,
  }) : super(key: key);
  final String text;
  final int questionIndex;
  final int answerIndex;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    var arr = ['A', 'B', 'C', 'D'];
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          return qnController.listQuestionSubmit
                      .firstWhere(
                          (element) => element.questionId == questionIndex)
                      .answerId ==
                  index
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ElasticIn(
                    child: InkWell(
                      onTap: press,
                      child: Container(
                        margin: EdgeInsets.only(top: kDefaultPadding),
                        padding: EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff6d7073), width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFebf7ff),
                        ),
                        child: Row(
                          children: [
                            // Text("${arr[answerIndex]}", style: TextStyle(fontSize: 16),),
                            choiceButton(Color(0xff28aaff), Color(0xffffffff),
                                arr[answerIndex]),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: IntrinsicHeight(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(2)),
                                  controller:
                                      new TextEditingController(text: "$text"),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  readOnly: true,
                                  expands: true,
                                  minLines: null,
                                  enabled: false,
                                  maxLines: null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: InkWell(
                    onTap: press,
                    child: Container(
                      margin: EdgeInsets.only(top: kDefaultPadding),
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff6d7073), width: 2),
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFfcfcfc),
                      ),
                      child: Row(
                        children: [
                          // Text("${arr[answerIndex]}", style: TextStyle(fontSize: 16),),
                          choiceButton(Color(0xffffffff), Color(0xff0c0c0c),
                              arr[answerIndex]),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: IntrinsicHeight(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(2)),
                                controller:
                                    new TextEditingController(text: "$text"),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                readOnly: true,
                                expands: true,
                                minLines: null,
                                enabled: false,
                                maxLines: null,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  Widget choiceButton(Color color, Color textColor, String text) =>
      //   Padding(
      // padding: const EdgeInsets.only(
      //     left: 16.0, right: 8.0, top: 8, bottom: 8),
      // child:
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54, width: 2)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: Container(
              color: color,
              height: 24,
              width: 30,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        // ),
      );
}
