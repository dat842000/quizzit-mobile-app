import 'package:flutter/material.dart';
import 'package:quizzit/Screens/UserViewGroup/components/body.dart';
import 'package:quizzit/models/group/Group.dart';

class UserViewScreen extends StatelessWidget {
  final Group group;
  UserViewScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(group),
    );
  }
}
