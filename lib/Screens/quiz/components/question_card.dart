import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/constants.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:flutter_auth/Screens/quiz/models/Questions.dart';
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              questionIndex: question.id,
              text: question.options[index],
              press: () {
                _controller.saveAnswer(question, index);
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: _controller.prevQuestion,
                      child: Icon(Icons.arrow_back_ios)),
                  FlatButton(
                      onPressed: _controller.nextQuestion,
                      child: Icon(Icons.arrow_forward_ios)),
                ]),
          ),
        ],
      ),
    );
  }
}
