import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? selectedImage;
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
