import 'package:flutter/material.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:flutter_auth/dtos/Post.dart';

import 'components/body.dart';

class EditPostScreen extends StatelessWidget{
  final Group group;
  final Post post;
  EditPostScreen(this.group,this.post);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Body(group,post),
    );
  }

}