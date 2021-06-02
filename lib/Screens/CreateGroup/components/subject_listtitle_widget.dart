import 'package:flutter/material.dart';

class SubjectListTitleWidget extends StatelessWidget {
  final String subject;
  final bool isSelected;
  final ValueChanged<String> onSelectedSubject;

  const SubjectListTitleWidget({
    Key key,
    @required this.subject,
    @required this.isSelected,
    @required this.onSelectedSubject,
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
        subject,
        style: style,
      ),
      trailing:
      isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}