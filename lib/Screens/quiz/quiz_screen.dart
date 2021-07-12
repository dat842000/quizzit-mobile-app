import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzit/Screens/quiz/controllers/question_controller.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/group/Group.dart';

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

  late QuestionController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller = Get.put(QuestionController());
    _controller.fetchQuestion(group.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          return qnController.listQuestions.length > 0
              ? Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          top: 11.0, bottom: 11.0, left: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          qnController.questionNumber.value = 1;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
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
                    actions: [
                      InkWell(
                          onTap: () {
                            qnController.goToQuestion(
                                qnController.listQuestions.length);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff65dc3f),
                                border:
                                    Border.all(color: Colors.black54, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16),
                                child: Text(
                                  "Finish",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ))
                    ],
                  ),
                  body: Body(
                    group: group,
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          top: 11.0, bottom: 11.0, left: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          qnController.questionNumber.value = 1;
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
                  body: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Center(
                          child: Text(
                            "Currently out of question!",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Image.asset(
                            "assets/images/undraw_Traveling_re_weve.png",
                            height: 250,
                          ),
                        ),
                      ],
                    ),
                  ));
        });
  }
}
