import 'package:flutter/material.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/post/Post.dart';

import 'components/body.dart';

class EditPostScreen extends StatelessWidget {
  final Group group;
  final Post post;
  EditPostScreen(this.group, this.post);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Body(group, post),
    );
  }
}
