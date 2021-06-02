import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_page.dart';
import 'package:flutter_auth/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String groupName , valueChoose;
  dynamic quizSize;
  List listItem = [
    "Toan",
    "Ly",
    "Hoa",
    "Su",
    "Dia",
    "Sinh hoc",
    "Anh van",
    "Cong nghe",
    "Tin hoc",
    "GDCD",
    "Ngu Van",
    "GDQP"
  ];
  String subject;
  File selectedImage;
  bool _isLoading = false;
  List<String> subjects = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: kPrimaryColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Create",
              style: TextStyle(fontSize: 30, color: Colors.black87),
            ),
            Text(
              "Group",
              style: TextStyle(fontSize: 30, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Color(0xffe4e6eb),
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
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
                                  selectedImage,
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Group Name"),
                          onChanged: (val) {
                            groupName = val;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            decoration: InputDecoration(hintText: "Quiz Size"),
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              quizSize = val;
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top:16.0, bottom: 16.0),
                        //   child: Container(
                        //     padding: EdgeInsets.only(
                        //       left: 16,
                        //       right: 16,
                        //     ),
                        //     width: MediaQuery.of(context).size.width,
                        //     decoration: BoxDecoration(
                        //         border:
                        //             Border.all(color: Colors.grey, width: 1),
                        //         borderRadius: BorderRadius.circular(15),
                        //
                        //     ),
                        //     child: DropdownButton(
                        //       hint: Text("Choose subject: "),
                        //       // dropdownColor: Colors.,
                        //       icon: Icon(Icons.arrow_drop_down),
                        //       iconSize: 36,
                        //       isExpanded: true,
                        //       underline: SizedBox(),
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 17,
                        //       ),
                        //       value: valueChoose,
                        //       onChanged: (newValue) {
                        //         setState(() {
                        //           valueChoose = newValue;
                        //         });
                        //       },
                        //       items: listItem.map((valueItem) {
                        //         return DropdownMenuItem(
                        //           value: valueItem,
                        //           child: Text(valueItem),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ),
                        // ),
                        Card(child: buildChoosingSubjects(),)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
  Widget buildChoosingSubjects(){
    final subjectsText = subjects.map((subject) => subject).join(', ');
    final onTap = () async{
      final subjects = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectPage(
              subjects: List.of(this.subjects),
          ),
        ),
      );
      if(subjects == null) return;
      setState(() => this.subjects = subjects);
    };
    return buildSubjectPicker(
      title: 'SelectSubjects',
      child: subjects.isEmpty
          ? buildListTile(title: 'No Subjects', onTap: onTap)
          : buildListTile(title: subjectsText, onTap: onTap),
    );
  }
  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }
  Widget buildSubjectPicker({
    @required String title,
    @required Widget child,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Card(margin: EdgeInsets.zero, child: child, color: Color(0xffe4e6eb),),
        ],
      );
}
