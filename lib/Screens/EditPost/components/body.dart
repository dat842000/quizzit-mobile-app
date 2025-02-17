import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/textfield_widget.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

import '../../../global/PostLib.dart' as globals;

class Body extends StatefulWidget {
  final Group group;
  final Post post;

  Body(this.group, this.post);

  @override
  _BodyState createState() => _BodyState(post: post);
}

class _BodyState extends State<Body> {
  final Post post;
  String title = "";
  File? selectedImage;
  var json;
  quill.QuillController _controller = quill.QuillController.basic();
  bool _isLoading = false;

  Future getImage() async {
    var picker = new ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _BodyState({required this.post}) {
    // this.selectedImage=Image;
    this.json = jsonDecode(post.content);
  }

  void createPost() {
    var json = jsonEncode(_controller.document.toDelta().toJson());
    var plainText = _controller.document.toPlainText();
    globals.content = json;
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
        title: Text('Edit Post'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              createPost();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserViewScreen(widget.group)));
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
                      child: TextFieldWidget(
                        label: "",
                        onChanged: (name) {
                          this.title = name;
                        },
                        text: post.title,
                      )),
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
                  quill.QuillToolbar.basic(
                      controller: _controller = quill.QuillController(
                          document: quill.Document.fromJson(json),
                          selection: TextSelection.collapsed(offset: 0))),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        quill.QuillEditor.basic(
                          controller: _controller = quill.QuillController(
                              document: quill.Document.fromJson(json),
                              selection: TextSelection.collapsed(offset: 0)),
                          readOnly: false,
                          // true for view only mode
                        ),
                        // QuillSimpleViewer(controller: _controller = quill.QuillController(
                        //     document: quill.Document.fromJson(myJSON),
                        //     selection: TextSelection.collapsed(offset: 0)),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
    ;
  }
}
