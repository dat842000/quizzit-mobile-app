import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:get/get.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
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
