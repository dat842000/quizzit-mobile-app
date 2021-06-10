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
    required this.press,
  }) : super(key: key);
  final String text;
  final int questionIndex;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheChooseAnswer() {
              if (qnController.questions.firstWhere((element) => element.id==questionIndex).choice == index) {
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
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}. $text",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
