import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/quiz_screen.dart';
import 'package:flutter_auth/models/group/Group.dart';

class ReadyScreen extends StatelessWidget {
  final Group group;

  ReadyScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          leadingWidth: 75,
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  "Ready To Do The Quiz?",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ClipOval(
                child: Image.asset(
                  "assets/images/quiz.jpg",
                  height: 250,
                ),
              ),
              SizedBox(height: 50,),
              FlatButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //   builder: (context) => QuizScreen(group),
                  // ));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(group)),
                      ModalRoute.withName("/Groups/${group.id}"));
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     QuizScreenExtractArgumentsScreen.routeName,
                  //     ModalRoute.withName(UserViewGroupExtractArgumentsScreen.routeName),
                  //     arguments: group);
                },
                child: Text(
                  "Do It Now!",
                  style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.red,
                    width: 2,
                    style: BorderStyle.solid
                ), borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
        ));
  }
}
