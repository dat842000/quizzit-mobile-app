import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/Screens/quiz/constants.dart';
import 'package:quizzit/models/questions/Question.dart';

// ignore: must_be_immutable
class AnswerRow extends StatelessWidget {
  Question question;
  int index;
  Function reRender;

  AnswerRow(this.question, this.index, this.reRender);

  @override
  Widget build(BuildContext context) {
    List<String> choices = ['A', 'B', 'C', 'D'];
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          var ans = question.answers
              .firstWhereOrNull((element) => element.isCorrect == true);
          if (ans != null) ans.isCorrect = false;
          question.answers[index].isCorrect = true;
          reRender();
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
          decoration: BoxDecoration(
            border: Border.all(color: kGrayColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${choices[index]}. ",
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 2 / 5,
                child: TextField(
                  controller: TextEditingController(
                      text: question.answers[index].content),
                  onChanged: (value) => question.answers[index].content = value,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 12),
                    hintText: "Đáp án ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              question.answers[index].isCorrect
                  ? Container(
                      height: 21,
                      width: 21,
                      decoration: BoxDecoration(
                        color: kGreenColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kGreenColor),
                      ),
                      child: Icon(Icons.done, size: 16),
                    )
                  : Container(
                      height: 21,
                      width: 21,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
