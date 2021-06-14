import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/models/post/Post.dart';


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
        title: Text(post.title.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              post.image.isEmpty
                  ? Padding(
                padding:
                const EdgeInsets.only(top: 8.0, bottom: 8.0),
              )
                  : CachedNetworkImage(
                imageUrl: post.image,
                height: 225,
                width:
                MediaQuery.of(context).size.width ,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                child: Align(
                  child: Text(post.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Text(post.content,style: TextStyle(fontSize: 17),)
            ],
          ),
        ),
      ),
    );
  }
}
