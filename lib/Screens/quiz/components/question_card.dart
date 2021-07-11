import 'package:flutter/material.dart';
import 'package:quizzit/Screens/quiz/components/process_bar.dart';
import 'package:quizzit/Screens/quiz/constants.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';
import 'package:quizzit/models/question/Question.dart';
import 'package:get/get.dart';

import 'option.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);
  final Question question;

  @override
  State<StatefulWidget> createState() => new QuestionCards();
}

class QuestionCards extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    var question = widget.question;
    QuestionController _controller = Get.put(QuestionController());
    double width = MediaQuery.of(context).size.width -40;
    double widthProcess = _controller.ans/_controller.listQuestions.length*width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Obx(
              () => Text.rich(
                TextSpan(
                  text: "Question ${_controller.questionNumber.value}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: kSecondaryColor),
                  children: [
                    TextSpan(
                      text: "/${_controller.listQuestions.length}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: kSecondaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: ProcessBar(widthProcess: widthProcess)),
          Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Divider(thickness: 1.5)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    question.content,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: kBlackColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.answers.length,
            (index) => Option(
              index: question.answers.elementAt(index).id,
              answerIndex: index,
              questionIndex: question.id,
              text: question.answers.elementAt(index).content,
              press: () {
                _controller.saveAnswer(
                    question, question.answers.elementAt(index).id);
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
