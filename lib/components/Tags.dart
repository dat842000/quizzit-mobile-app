import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 80.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}

class ContinueTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 30.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}