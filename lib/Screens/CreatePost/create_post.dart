import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreatePost/components/body.dart';
import 'package:flutter_auth/models/group/Group.dart';

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