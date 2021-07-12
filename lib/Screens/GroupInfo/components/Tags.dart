import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      width: 95.0,
      decoration: BoxDecoration(
        color: Color(0xff75c7c9),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black54,width: 2)
      ),
      alignment: Alignment.center,
      child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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