import 'package:flutter/material.dart';

class Divide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.symmetric(vertical: size.height ),
      // width: size.width ,
      child: Row(
        children: <Widget>[
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xfff3f4fb),
        height: 3,
        thickness: 2,
      ),
    );
  }
}
