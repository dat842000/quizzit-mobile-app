import 'package:flutter/material.dart';
import 'package:quizzit/Screens/quiz/quiz_screen.dart';
import 'package:quizzit/models/group/Group.dart';

class ReadyScreen extends StatelessWidget {
  final Group group;

  ReadyScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(
                top: 11.0, bottom: 11.0, left: 20, right: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff8d966),
                    border:
                    Border.all(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.0,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          leadingWidth: 75,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 80,
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
            ClipOval(
              child: Image.asset(
                "assets/images/undraw_Outer_space_drqu.png",
                height: 250,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => QuizScreen(group)),
                    ModalRoute.withName("/Groups/${group.id}"));
              },
              child: buildSubmit(),
            )
          ],
        ));
  }
}
Widget buildSubmit() => Container(
  width: 120,
  height: 56,
  child: Stack(children: [
    Positioned(
        top: 5,
        left: 5,
        width: 114,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff51b1d3),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.black87, width: 2)),
        )),
    Container(
      width: 114,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xfff8d966),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black87, width: 2)),
      child: Center(child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),))
    ),
  ]),
);
