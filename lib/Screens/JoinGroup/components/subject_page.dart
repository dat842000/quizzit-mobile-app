import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_listtitle_widget.dart';

class SubjectPage extends StatefulWidget {
  final List<String> subjects;
  const SubjectPage({
    Key? key,
    this.subjects = const[],
  }) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<String> selectedSubjects = [];
  List listSubject = [
    "Toan",
    "Ly",
    "Hoa",
    "Su",
    "Dia",
    "Sinh hoc",
    "Anh van",
    "Cong nghe",
    "Tin hoc",
    "GDCD",
    "Ngu Van",
    "GDQP"
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

  void selectSubject(String subject) {
    final isSelected = selectedSubjects.contains(subject);
    setState(() => isSelected
        ? selectedSubjects.remove(subject)
        : selectedSubjects.add(subject));
  }
  void submit() => Navigator.pop(context, selectedSubjects);
}
