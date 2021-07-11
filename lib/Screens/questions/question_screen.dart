import 'package:flutter/material.dart';
import 'package:quizzit/Screens/questions/component/body.dart';
import 'package:quizzit/Screens/questions/question_info_screen.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/questions/Answers.dart';
import 'package:quizzit/models/questions/Question.dart';
import 'package:quizzit/utils/snackbar.dart';

class QuestionScreen extends StatelessWidget {
  final Group group;
  QuestionScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: deprecated_member_use
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        leadingWidth: 75,
        actions: [
          GestureDetector(
            onTap: () {
              if (group.subjects.length != 0) {
                List<Answer> listAns = [
                  new Answer(0, "", false),
                  new Answer(0, "", false)
                ];
                Question question =
                    Question.temp("", group.subjects[0].id, true, listAns);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          QuestionInfoScreen(question, true, group)),
                );
              } else {
                showError(
                    text: "Nhóm hiện tại không có môn học", context: context);
              }
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
      body: Body(group),
    );
  }
}
