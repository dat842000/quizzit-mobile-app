import 'package:flutter/material.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/models/group/Group.dart';

class RecordScreen extends StatefulWidget {
  final Group group;
  final int correctAnswers;
  final int questions;
  RecordScreen(this.group, this.correctAnswers, this.questions);

  @override
  State createState() =>
      _RecordScreenState(this.group, this.correctAnswers, this.questions);
}

class _RecordScreenState extends State<RecordScreen> {
  final Group group;
  final int correctAnswers;
  final int questions;
  _RecordScreenState(this.group, this.correctAnswers, this.questions);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FlatButton(
            onPressed: () => Navigate.popToGroup(context, group.id),
            child: Icon(Icons.arrow_back)),
        leadingWidth: 75,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text("Your result is:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('$correctAnswers/$questions',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    // fixedSize: Size(120, 120),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(24),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
