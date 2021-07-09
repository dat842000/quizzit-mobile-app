import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/quiz/components/answer_row.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/questions/Answers.dart';
import 'package:flutter_auth/models/questions/Question.dart';

// ignore: must_be_immutable
class QuestionInfo extends StatefulWidget {
  QuestionInfo(this.question, this.isNew, this.group);

  Group group;
  bool isNew;
  Question question;

  @override
  _QuestionInfo createState() => _QuestionInfo(question);
}

class _QuestionInfo extends State<QuestionInfo> {
  Question question;

  _QuestionInfo(this.question);

  @override
  Widget build(BuildContext context) {
    Answer tempAns = new Answer(0, "", false);
    List<DropdownMenuItem> items = widget.group.subjects.map((item) {
      return DropdownMenuItem<int>(
        child: Text(item.name),
        value: item.id,
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
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
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: TextEditingController(text: question.content),
                      onChanged: (value) => question.content = value,
                      decoration: InputDecoration(
                        hintText: "Câu hỏi...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black),
                          borderRadius:
                              BorderRadius.all(Radius.circular(14.0))),
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width * 3 / 5,
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        underline: Container(color: Colors.white, height: 1.0),
                        items: items,
                        value: question.inSubject,
                        onChanged: (newVal) {
                          setState(() =>
                          question.inSubject = int.parse(newVal.toString()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  widget.isNew != true ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Câu hỏi công khai ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Checkbox(
                            value: !question.isPrivate!,
                            onChanged: (newVal) {
                              setState(() =>
                              question.isPrivate = !question.isPrivate!);
                            },
                        ),
                      ),
                    ],
                  ) : SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Đáp án ",
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
                      Text("Câu đúng ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  ...List.generate(
                    question.answers.length,
                    (index) => Dismissible(
                        key: Key(UniqueKey().toString()),
                        child:
                            AnswerRow(question, index, () => {setState(() {})}),
                        direction: question.answers.length > 2
                            ? DismissDirection.horizontal
                            : DismissDirection.none,
                        onDismissed: (direction) {
                          setState(() {
                            question.answers.removeAt(index);
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  question.answers.length < 4 ?
                  InkWell(
                    onTap: (){
                      setState(() {
                        question.answers.add(tempAns);
                      });
                    },
                    child: DottedBorder(
                        color: Colors.lightBlue,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(6),
                        strokeWidth: 1,
                        dashPattern: [6],
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: 16, color: Colors.lightBlue),
                              Text(
                                "Thêm ",
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                  ) : SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
