import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quizzit/Screens/quiz/constants.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';

class Choice extends StatelessWidget {
  const Choice({
    Key? key,
    required this.questionIndex,
  }) : super(key: key);
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          return InkWell(
            onTap: () => qnController.goToQuestion(questionIndex),
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  border: Border.all(color: kGrayColor),
                  borderRadius: BorderRadius.circular(15),
                  color: qnController.listQuestionSubmit
                              .elementAt(questionIndex)
                              .answerId !=
                          -1
                      ? kGreenColor
                      : kRedColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${questionIndex + 1}: ${qnController.listQuestionSubmit.elementAt(questionIndex).answerId != -1 ? "Done" : "Not Done"}",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
