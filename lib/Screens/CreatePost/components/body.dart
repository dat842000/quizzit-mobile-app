import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:quizzit/Screens/PostDetail/post_detail.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/rounded_input_field.dart';
import 'package:quizzit/components/show_photo_menu.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/global/Subject.dart' as state;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/post/CreatePostModel.dart';
import 'package:quizzit/models/post/Post.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/FirebaseUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

class Body extends StatefulWidget {
  final Group _group;

  Body(this._group);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _title = "";
  File? _selectedImage;
  quill.QuillController _controller = quill.QuillController.basic();
  bool _isLoading = false;
  FocusNode _inputNode = FocusNode();

  void showKeyboard() {
    FocusScope.of(context).requestFocus(_inputNode);
  }

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
    String? image;

    if (_selectedImage != null)
      image = await FirebaseUtils.uploadImage(_selectedImage!,
          uploadLocation: UploadLocation.Posts,
          whileUpload: (int byteTransfered, int totalBytes) {},
          onError: (Object? error) {});
    CreatePostModel model = CreatePostModel(
        this._title, jsonEncode(_controller.document.toDelta().toJson()),
        image: image);
    fetch(Host.groupPost(groupId: widget._group.id), HttpMethod.POST,
            data: model)
        .then((value) {
      if (!value.statusCode.isOk()) {
        showError(
            text: ProblemDetails.fromJson(json.decode(value.body)).title!,
            context: context);
      } else {
        state.setPost[1].call(Post.fromJson(json.decode(value.body)));
        showSuccess(text: "Tạo bài viết mới thành công", context: context);
        Navigate.pushReplacement(
            context,
            PostDetailScreen(
                Post.fromJson(json.decode(value.body)), widget._group.id));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 1.0),
                BoxShadow(color: Colors.black12, spreadRadius: 3.0),
                // BoxShadow(color: Colors.grey, spreadRadius: 4.0)
              ]),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigate.popToGroup(context, widget._group.id);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                    color: kPrimaryColor,
                  ),
                  Text(
                    'Create Post',
                    style: TextStyle(
                        fontSize: 25,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      EasyLoading.show(
                          status: 'Đang tạo...',
                          maskType: EasyLoadingMaskType.black);
                      await createPost();
                      EasyLoading.dismiss();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.file_upload,
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // AppBar(
        //     backgroundColor: Colors.white,
        //     leading:
        //     title:
        //     actions: <Widget>[
        //
        //     ],
        //   ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _isLoading
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
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            buildPhotoPickerMenu(context,
                                onPick: (pickedImage) {
                              setState(() {
                                this._selectedImage = pickedImage;
                              });
                            });
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
                          // showHorizontalRule: true,
                          onImagePickCallback: (file) async {
                            FocusScope.of(context).unfocus();
                            var url = await FirebaseUtils.uploadImage(file,
                                uploadLocation: UploadLocation.Posts,
                                whileUpload:
                                    (int byteTransfered, int totalBytes) {},
                                onError: (Object? error) {});

                            return url;
                          }),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: kPrimaryColor)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            quill.QuillEditor(
                              controller: _controller,
                              focusNode: _inputNode,
                              keyboardAppearance:
                                  MediaQuery.of(context).platformBrightness,
                              scrollController: ScrollController(),
                              scrollable: true,
                              autoFocus: true,
                              expands: false,
                              minHeight: 230,
                              padding: EdgeInsets.all(10),
                              readOnly: false, // true for view only mode
                              // embedBuilder: (context, node) {
                              //
                              // },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
