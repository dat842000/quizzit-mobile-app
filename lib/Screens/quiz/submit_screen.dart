import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/controllers/question_controller.dart';
import 'package:flutter_auth/Screens/quiz/quiz_screen.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:get/get.dart';

import 'components/SummaryResult.dart';

class SubmitScreen extends StatefulWidget {
  final Group group;
  SubmitScreen(this.group);

  @override
  State createState() => _SubmitScreenState(this.group);
}
class _SubmitScreenState extends State<SubmitScreen> {
  Group group;
  _SubmitScreenState(this.group);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          // qnController.fetchQuestion(group.id);
          return Scaffold(
            extendBodyBehindAppBar: true,

            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   leading: FlatButton(onPressed:() {
            //     Navigator.pop(context);
            //     // qnController.questionNumber.value = 1;
            //   }
            //       , child: Icon(Icons.arrow_back)),
            //   leadingWidth: 75,
            // ),
            body: SummaryResult(group),
          );
        });
  }
}
