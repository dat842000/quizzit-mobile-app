
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:get/get.dart';

import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  final Group group;

  QuizScreen(this.group);

  @override
  State createState() => _QuizScreenState(this.group);
}

class _QuizScreenState extends State<QuizScreen> {
  Group group;

  _QuizScreenState(this.group);

  late QuestionController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller = Get.put(QuestionController());
    _controller.fetchQuestion(group.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          return qnController.listQuestions.length > 0
              ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    qnController.questionNumber.value = 1;
                  },
                  child: Icon(Icons.arrow_back)),
              leadingWidth: 75,
              actions: [
                FlatButton(
                    onPressed: () {
                      qnController.goToQuestion(qnController.listQuestions.length);
                    },
                    child: Icon(Icons.done))
              ],
            ),
            body: Body(group: group,),
          )
              : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      qnController.questionNumber.value = 1;
                    },
                    child: Icon(Icons.arrow_back)),
                leadingWidth: 75,
              ),
              body: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Center(
                      child: Text(
                        "Currently out of question!",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        "assets/icons/cry_face.png",
                        height: 250,
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
