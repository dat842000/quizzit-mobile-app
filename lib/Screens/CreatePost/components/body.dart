import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/post/CreatePostModel.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/FirebaseUtils.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  final Group group;

  Body(this.group);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _title = "";
  File? _selectedImage;
  quill.QuillController _controller = quill.QuillController.basic();
  TextEditingController _textEditingController = TextEditingController();
  bool _isLoading = false;

  Future getImage() async {
    var picker = new ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _selectedImage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future createPost() async {
    var image = _selectedImage != null
        ? await FirebaseUtils.uploadImage(_selectedImage!)
        : null;
    CreatePostModel model = CreatePostModel(
        this._title, jsonEncode(_controller.document.toDelta().toJson()),image: image);
    fetch(Host.groupPost(groupId: widget.group.id), HttpMethod.POST,data: model)
      .then((value) {
        Navigate.push(context,PostDetailScreen(Post.fromJson(json.decode(value.body))));
      });
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () async{
              await createPost();
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
                      child: RoundedInputField(
                        icon: Icons.title,
                        hintText: "Post Title",
                        onChanged: (String value) => this._title = value,
                      )
                      // TextFieldWidget(
                      //   label: "",onChanged: (name){
                      //     this.title = name;
                      // },text: "Post title",
                      // )
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () async{
                        await getImage();
                      },
                      child: _selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  _selectedImage!,
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
                    controller: _controller,
                    onImagePickCallback: (file) =>
                        FirebaseUtils.uploadImage(file),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: kPrimaryColor)),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        quill.QuillEditor(
                          controller: _controller,
                          focusNode: FocusNode(),
                          scrollController: ScrollController(),
                          scrollable: true,
                          autoFocus: true,
                          expands: false,
                          minHeight: 230,
                          padding: EdgeInsets.all(10),
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
