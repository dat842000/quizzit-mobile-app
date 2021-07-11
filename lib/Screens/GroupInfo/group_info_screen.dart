import 'package:flutter/material.dart';
import 'package:quizzit/models/group/Group.dart';

import 'components/body.dart';

class GroupInfoScreen extends StatelessWidget {
  final Group group;
  Function update;
  GroupInfoScreen(this.group, this.update);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Body(group, update),
    );
  }
}
