import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/textfield_widget.dart';
import 'package:flutter_auth/global/ListPost.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/utils/FirebaseUtils.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import '../../../global/PostLib.dart' as globals;

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
        print(_selectedImage);
      } else {
        print('No image selected.');
      }
    });
  }
  void createPost(){
    var json = jsonEncode(_controller.document.toDelta().toJson());
    var plainText = _controller.document.toPlainText();
    print(json);
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
                      child: RoundedInputField(hintText: "Post Title", onChanged: (String value) =>this._title=value,)
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
                      onTap: () {
                        getImage();
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
                  quill.QuillToolbar.basic(controller: _controller,onImagePickCallback: (file)=>FirebaseUtils.uploadImage(file),),
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
