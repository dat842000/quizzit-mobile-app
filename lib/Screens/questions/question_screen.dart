import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/questions/component/body.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

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
      body: Body(),
    );
  }
}
