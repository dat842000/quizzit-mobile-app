import 'package:flutter/material.dart';
import 'package:quizzit/Screens/ListUser/components/body.dart';
import 'package:quizzit/models/group/Group.dart';

class ListUser extends StatelessWidget {
  const ListUser({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Body(group: group);
  }
}
