import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/constants.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
          Color getTheChooseAnswer() {
            if (qnController.listQuestionSubmit.firstWhere((element) => element.questionId==questionIndex).answerId == index) {
              return kChooseColor;
            }
            return kGrayColor;
          }
          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getTheChooseAnswer()),
                borderRadius: BorderRadius.circular(15),
                color: getTheChooseAnswer(),
              ),
              child:
              Row(
                children: [
                  Text("${arr[answerIndex]}. ", style: TextStyle(fontSize: 16),),

                  Flexible(
                    child: IntrinsicHeight(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(2)),
                      controller: new TextEditingController(
                          text: "$text"),
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
                  )],
              ),
            ),
          );
        });
  }
}
