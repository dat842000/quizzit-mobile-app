import 'package:flutter/material.dart';
import 'package:flutter_auth/models/group/Group.dart';

import 'components/body.dart';



class InfoUpdateGroupScreen extends StatelessWidget {
  final Group group;
  Function update;
  InfoUpdateGroupScreen(this.group,this.update);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(group,update),
    );
  }
}