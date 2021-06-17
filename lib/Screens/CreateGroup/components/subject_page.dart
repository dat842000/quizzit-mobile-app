import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_listtitle_widget.dart';
import 'package:flutter_auth/dtos/Subject.dart';

class SubjectPage extends StatefulWidget {
  final List<Subject> subjects;
  const SubjectPage({
    Key? key,
    this.subjects = const[],
  }) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Subject> selectedSubjects = [];
  List<Subject> listSubject = [
    // "Toan",
    // "Ly",
    // "Hoa",
    // "Su",
    // "Dia",
    // "Sinh hoc",
    // "Anh van",
    // "Cong nghe",
    // "Tin hoc",
    // "GDCD",
    // "Ngu Van",
    // "GDQP"
    Subject(1, "Toan"),
    Subject(2, "Ly"),
    Subject(3, "Hoa"),
    Subject(4, "Su"),
    Subject(5, "Dia"),
    Subject(6, "Sinh hoc"),
    Subject(7, "Anh van"),
    Subject(8, "Cong nghe"),
    Subject(9, "Tin hoc"),
    Subject(10, "GDCD"),
    Subject(11, "Ngu Van"),
    Subject(12, "GDQP"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subjects'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: listSubject.map((subject) {
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
