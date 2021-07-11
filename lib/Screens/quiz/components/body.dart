import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzit/Screens/quiz/constants.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';
import 'package:quizzit/Screens/quiz/submit_screen.dart';
import 'package:quizzit/models/group/Group.dart';

import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.group,
  }) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.find();
    _questionController.resetPageController();
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.listQuestions.length + 1,
                  itemBuilder: (context, index) =>
                      index < _questionController.listQuestions.length
                          ? QuestionCard(
                              question: _questionController.listQuestions
                                  .elementAt(index))
                          : SubmitScreen(group),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: _questionController.prevQuestion,
                        child: Icon(Icons.arrow_back_ios)),
                    FlatButton(
                        onPressed: _questionController.nextQuestion,
                        child: Icon(Icons.arrow_forward_ios)),
                  ]),
            ],
          ),
        )
      ],
    );
  }
}
