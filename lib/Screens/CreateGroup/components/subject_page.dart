import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_listtitle_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

import 'package:flutter_auth/global/Subject.dart' as subject;

class SubjectPage extends StatefulWidget {
  final List<Subject> subjects;
  const SubjectPage({
    Key? key,
    this.subjects = const[],
  }) : super(key: key);

  Future<List<Subject>> getSubjects() async{
    var response = await fetch(Host.subjects, HttpMethod.GET);
    Iterable i = json.decode(response.body);
    return List<Subject>.from(i.map((m) => Subject.fromJson(m)));
  }

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Subject> selectedSubjects = [];
  late Future<List<Subject>> listSubjectFuture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subjects'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              //TODO Subject
              children: subject.subjects.map((subject) {
                final isSelected = selectedSubjects.contains(subject);
                return SubjectListTitleWidget(
                  subject: subject,
                  isSelected: isSelected,
                  onSelectedSubject: selectSubject,
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }
  Widget buildSelectButton(BuildContext context){
    final label = 'Select ${selectedSubjects.length} Subjects';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical:12),
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: submit,
      ),
    );
  }

  void selectSubject(Subject subject) {
    final isSelected = selectedSubjects.contains(subject);
    setState(() => isSelected
        ? selectedSubjects.remove(subject)
        : selectedSubjects.add(subject));
  }
  void submit() => Navigator.pop(context, selectedSubjects);
}
