import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:quizzit/Screens/PostDetail/post_detail.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/textfield_widget.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/global/Subject.dart' as state;
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/post/EditPostModel.dart';
import 'package:quizzit/models/post/Post.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/FirebaseUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

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
  bool isDelete = false;
  late quill.QuillController _controller;
  bool _isLoading = false;
  FocusNode _inputNode = FocusNode();

  void showKeyboard() {
    _inputNode.requestFocus();
  }

  Future getImage() async {
    var picker = new ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    isDelete = false;
    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future editPost() async {
    String? image = post.image;
    EasyLoading.show(
        status: 'Đang cập nhật...', maskType: EasyLoadingMaskType.black);
    if (selectedImage != null)
      image = await FirebaseUtils.uploadImage(selectedImage!,
          uploadLocation: UploadLocation.Posts,
          whileUpload: (int byteTransfered, int totalBytes) {},
          onError: (Object? error) {
        EasyLoading.dismiss();
        showError(
            text: "Upload Image Failed, Please Try Again.", context: context);
      });
    if (isDelete) image = null;
    EditPostModel model = EditPostModel(
        this.title, jsonEncode(_controller.document.toDelta().toJson()), image);
    fetch(Host.editPost(post.id), HttpMethod.PUT, data: model).then((value) {
      EasyLoading.dismiss();
      if (!value.statusCode.isOk()) {
        showError(
            text: ProblemDetails.fromJson(json.decode(value.body)).title!,
            context: context);
      } else {
        post.title = model.title;
        post.content = model.content;
        post.image = model.image;
        state.setPost[2].call(this.post);
        showSuccess(text: "Sửa bài viết thành công", context: context);
        Navigate.pushReplacement(
            context, PostDetailScreen(this.post, widget.group.id));
      }
    });
  }

  _BodyState({required this.post}) {
    this.json = jsonDecode(post.content);
  }

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController(
        document: quill.Document.fromJson(jsonDecode(post.content)),
        selection: TextSelection(baseOffset: 0, extentOffset: 0));
    this.title = post.title;
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width,
      child: Icon(
        Icons.add_a_photo,
        color: Colors.black45,
      ),
    );
    if (selectedImage == null && post.image != null && isDelete == false) {
      image = Stack(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 170,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: post.image ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 25,
            child: InkWell(
                onTap: () {
                  setState(() {
                    selectedImage = null;
                    isDelete = true;
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 20,
                )))
      ]);
    }
    if (selectedImage != null && isDelete == false) {
      image = Stack(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 170,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              selectedImage!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 25,
            child: InkWell(
                onTap: () {
                  setState(() {
                    selectedImage = null;
                    isDelete = false;
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 20,
                )))
      ]);
    }
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigate.popToGroup(context, widget.group.id);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: kPrimaryColor,
              )),
          title: Text(
            'Edit Post',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                EasyLoading.show(
                    status: 'Đang cập nhật...',
                    maskType: EasyLoadingMaskType.black);
                await editPost();
                EasyLoading.dismiss();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UserViewScreen(widget.group)));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.file_upload,
                    color: kPrimaryColor,
                  )),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                          child: TextFieldWidget(
                            label: "",
                            onChanged: (name) {
                              setState(() {
                                this.title = name;
                              });
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
                        // child: selectedImage != null ?
                        child: image,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      quill.QuillToolbar.basic(
                          controller: _controller,
                          // showHorizontalRule: true,
                          onImagePickCallback: (file) async {
                            FocusScope.of(context).unfocus();
                            return await FirebaseUtils.uploadImage(file,
                                uploadLocation: UploadLocation.Posts,
                                whileUpload:
                                    (int byteTransfered, int totalBytes) {},
                                onError: (Object? error) {});
                          }),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
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
                              showCursor: true,
                              expands: false,
                              minHeight: 230,
                              padding: EdgeInsets.all(10),
                              readOnly: false, // true for view only mode
                              // embedBuilder: (context, node) {},
                            ),
                            // quill.QuillEditor.basic(
                            //   controller: _controller = quill.QuillController(
                            //       document: quill.Document.fromJson(json),
                            //       selection: TextSelection.collapsed(offset: 0)),
                            //   readOnly: false,
                            //   // true for view only mode
                            // ),
                            // QuillSimpleViewer(controller: _controller = quill.QuillController(
                            //     document: quill.Document.fromJson(myJSON),
                            //     selection: TextSelection.collapsed(offset: 0)),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
