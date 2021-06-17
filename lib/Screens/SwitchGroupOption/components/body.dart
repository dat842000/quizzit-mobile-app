import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SwitchGroupOption/components/build_settings.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: <Widget>[
            BuildSettings(),
          ],
        ),
      ),
    );
  }
}
