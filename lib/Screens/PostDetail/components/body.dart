import 'package:flutter/material.dart';
import 'package:flutter_auth/dtos/Post.dart';

class Body extends StatelessWidget {
  final Post post;

  Body(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: Text(post.title),
      ),
    );
  }
}
