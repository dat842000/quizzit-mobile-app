import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/ListUser/components/body.dart';
import 'package:flutter_auth/models/group/Group.dart';

class ListUser extends StatelessWidget{
  const ListUser({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Body(group : group);
  }

}