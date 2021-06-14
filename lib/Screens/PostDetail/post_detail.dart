import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/body.dart';
import 'package:flutter_auth/models/post/Post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  PostDetailScreen(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(post),
    );
  }
}