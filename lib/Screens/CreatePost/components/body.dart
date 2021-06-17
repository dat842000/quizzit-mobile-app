import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/components/textfield_widget.dart';
import 'package:flutter_auth/dtos/Post.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:flutter_auth/global/ListPost.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import '../../../global/PostLib.dart' as globals;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? selectedImage;
  quill.QuillController _controller = quill.QuillController.basic();
  bool _isLoading = false;
  String title = "";
  Future getImage() async {
    var picker = new ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
        print(selectedImage);
      } else {
        print('No image selected.');
      }
    });
  }
  void createPost(){
    var json = jsonEncode(_controller.document.toDelta().toJson());
    globals.content = json;
    var post = new Post("Some random title", DateTime.now(), selectedImage, json, User(
        1,
        "Dat Nguyen",
        "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
        "dnn8420@gmail.com",
        DateTime.now()));
    ListPost.listPost.add(post);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        elevation: 0.0,
        title: Text('Create Post'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              createPost();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.file_upload,
                )),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: TextFieldWidget(label: "",onChanged: (name){},text: "Post title",)),

                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  quill.QuillToolbar.basic(controller: _controller),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children:[
                        quill.QuillEditor.basic(
                          controller: _controller,
                          readOnly: false, // true for view only mode
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
