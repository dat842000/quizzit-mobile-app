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
  QuestionController _controller = Get.put(QuestionController());

  @override
  void initState() {
    _controller.fetchQuestion(group.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(onPressed:() {
          Navigator.pop(context);
          _controller.questionNumber.value = 1;
          }
          , child: Icon(Icons.arrow_back)),
        leadingWidth: 75,
        actions: [
          FlatButton(onPressed: () {
            
          }
              , child: Icon(Icons.done)),
        ],
      ),
      body: Body(),
    );
  }
}
