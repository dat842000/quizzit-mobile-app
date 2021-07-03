import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/body.dart';
import 'package:flutter_auth/models/post/Post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post _post;
  final int _groupId;
  PostDetailScreen(this._post,this._groupId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_post,_groupId),
    );
  }
}