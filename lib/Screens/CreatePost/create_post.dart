import 'package:flutter/material.dart';
import 'package:quizzit/Screens/CreatePost/components/body.dart';
import 'package:quizzit/models/group/Group.dart';

class CreatePostScreen extends StatelessWidget {
  final Group group;
  CreatePostScreen(this.group);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(group),
    );
  }
}
