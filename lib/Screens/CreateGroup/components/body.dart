import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_page.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/Subject.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String groupName="" , valueChoose="";
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
  String subject="";
  File? selectedImage;
  bool _isLoading = false;
  List<Subject> subjects = [];

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
                        getImage().then((value) { print("1");
                            print(selectedImage);});

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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Group Name",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) {
                              groupName = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Quiz Size",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              quizSize = val;
                            },
                          ),
                        ),
                        Card(child: buildChoosingSubjects(),)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildChoosingSubjects() {
    final subjectsText = subjects.map((subject) => subject.name).join(', ');
    final ids = subjects.map((subject) => subject.id);
    final onTap = () async {
      final subjects = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectPage(
            subjects: List.of(this.subjects),
          ),
        ),
      );
      if (subjects == null) return;
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
    required String title,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color(0xff646465), fontSize: 17),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Color(0xff646465)),
    );
  }
  Widget buildSubjectPicker({
    required String title,
    required Widget child,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: child,
            color: Color(0xffe4e6eb),
          ),
        ],
      );
}
