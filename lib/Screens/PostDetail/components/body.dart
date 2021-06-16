import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/components/comment.dart';
import 'package:flutter_auth/Screens/PostDetail/model/comments_data.dart'
    as comments;
import 'package:flutter_auth/dtos/Post.dart';

class Body extends StatefulWidget{
  final Post post;
  Body(this.post);

  @override
  PostDetail createState() => PostDetail(post : post);
}

class PostDetail extends State<Body> {
  List<comments.Comment> list = comments.list;
  final Post post;

  PostDetail({required this.post});

  TextEditingController controller = new TextEditingController();
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue[300]),
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 2.0))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: controller,
                  decoration:
                      InputDecoration.collapsed(hintText: "Write a comment"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      var content = controller.text;
                      comments.Comment cmt = new comments.Comment(id: comments.list.length, name: "Dat Nguyen",
                          content: content, imageUrl: comments.currentUser.imageUrl, dateUp: DateTime.now());
                      comments.list.add(cmt);
                      controller.text = "";
                      setState(() {});
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: Text(post.title.toUpperCase()),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 1.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          post.urlImg.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                )
                              : CachedNetworkImage(
                                  imageUrl: post.urlImg,
                                  height: 225,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Align(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 3),
                                child: Text(
                                  post.title.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Text(
                            post.content,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 6),
                        child: Text("Comment",
                          style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(
                    list.length,
                    (index) => CommentWidget(
                      comment: list[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }
}
