import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/dtos/Subject.dart';
import 'package:flutter_auth/models/questions/Question.dart';

import 'package:flutter_auth/global/Subject.dart' as subject;

// ignore: must_be_immutable
class QuestionInfo extends StatefulWidget {
  QuestionInfo(this.question);

  Question question;

  @override
  _QuestionInfo createState() => _QuestionInfo(question);
}

class _QuestionInfo extends State<QuestionInfo> {
  Question question;

  _QuestionInfo(this.question);

  List<TextEditingController> _controller =
      List.generate(4, (i) => TextEditingController());

  @override
  void initState() {
    _controller[0] = TextEditingController(text: question.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = subject.subjects.map((item) {
      return DropdownMenuItem<String>(
        child: Text(item.name),
        value: item.id.toString(),
      );
    }).toList();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Câu hỏi ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("*",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller : _controller[0],
                      decoration: InputDecoration(
                        hintText: "Câu hỏi...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Môn học ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("*",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: DropdownButton(
                      items: items,
                      // onChanged: (_) {},
                    )
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
