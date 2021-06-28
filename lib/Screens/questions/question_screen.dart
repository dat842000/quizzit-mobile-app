import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/questions/component/body.dart';
import 'package:flutter_auth/Screens/questions/question_info_screen.dart';
import 'package:flutter_auth/models/questions/Answers.dart';
import 'package:flutter_auth/models/questions/Question.dart';

class QuestionScreen extends StatelessWidget {
  final int groupId;
  QuestionScreen(this.groupId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: deprecated_member_use
        leading: FlatButton(onPressed:() {
          Navigator.pop(context);
          }
          , child: Icon(Icons.arrow_back)),
        leadingWidth: 75,
        actions: [
          GestureDetector(
            onTap: () {
              List<Answer> listAns = [new Answer(0, "", false), new Answer(0, "", false)];
              Question question = Question.temp("", 0, true, listAns);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => QuestionInfoScreen(question, true, groupId)
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Body(groupId),
    );
  }
}
