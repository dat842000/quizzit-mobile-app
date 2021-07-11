import 'package:flutter/material.dart';
import 'package:quizzit/models/group/Group.dart';

import 'components/body.dart';

class UpdateGroupScreen extends StatelessWidget {
  final Group group;
  final Function update;
  UpdateGroupScreen(this.group, this.update);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(group, update),
    );
  }
}
