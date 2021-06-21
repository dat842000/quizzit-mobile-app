import 'package:flutter/material.dart';
import 'package:flutter_auth/models/subject/Subject.dart';

class SubjectListTitleWidget extends StatelessWidget {
  final Subject subject;
  final bool isSelected;
  final ValueChanged<Subject> onSelectedSubject;

  const SubjectListTitleWidget({
    Key? key,
    required this.subject,
    required this.isSelected,
    required this.onSelectedSubject,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
      fontSize: 18,
      color: selectedColor,
      fontWeight: FontWeight.bold,
    )
        : TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedSubject(subject),
      title: Text(
        subject.name,
        style: style,
      ),
      trailing:
      isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}