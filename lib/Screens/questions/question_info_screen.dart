import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/questions/component/QuestionInfo.dart';

import 'package:flutter_auth/models/questions/Question.dart';

// ignore: must_be_immutable
class QuestionInfoScreen extends StatelessWidget {

  Question question;
  QuestionInfoScreen(this.question);

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
      ),
      body: QuestionInfo(question),
    );
  }
}
