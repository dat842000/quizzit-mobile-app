import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlurryDialog extends StatefulWidget {
  String title;
  String content;
  VoidCallback continueCallBack;
  BlurryDialog(
      this.title,this.content,this.continueCallBack);
  @override
  _BlurryDialogState createState() => _BlurryDialogState(this.title,this.content,this.continueCallBack);
}
class  _BlurryDialogState extends State<BlurryDialog> {

  String title;
  String content;
  VoidCallback continueCallBack;
  File? selectedImage;
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

  _BlurryDialogState(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: new Text(title,style: textStyle,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(content, style: textStyle,),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write your reason...'
                  ),
                ),
                SizedBox(height: 20,),
                Text("Report image: ", style: textStyle,),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {
                      getImage().then((value) {
                        print(selectedImage);
                      });
                    },
                    child: selectedImage != null
                        ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      height: 140,
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
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.black54, width: 2)
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.black45,
                      ),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Report"),
              onPressed: () {
                continueCallBack();
              },
            ),
            new FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}