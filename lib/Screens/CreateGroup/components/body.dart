import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/components/subject_page.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/CreateGroupModel.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/FirebaseUtils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CreateGroupModel _createGroupModel = new CreateGroupModel("", 10, null, []);
  File? _selectedImage;
  bool _isLoading = false;
  List<Subject> _subjects = [];

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

  Future<void> createGroup() async {
    //TODO CreateGroup
    String? image;
    if (this._selectedImage != null)
      image = await FirebaseUtils.uploadImage(_selectedImage!);
    if (this._subjects.isNotEmpty)
      _subjects.map((e) => this._createGroupModel.subjectIds.add(e.id));
    this._createGroupModel.image = image;
    var response =
        await fetch(Host.groups, HttpMethod.POST, data: this._createGroupModel);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk()) {
      var newGroup = Group.fromJson(jsonRes);
      showAlert(context, "Create Group Success",
          "Your Group has been created success fully",
          onPressed: (context) =>
              Navigate.push(context, UserViewScreen(newGroup)));
    } else {
      ProblemDetails problem = ProblemDetails.fromJson(jsonRes);
      showAlert(context, "Create Failed", problem.title!,
          onPressed: (context) => Navigate.pop(context));
    }
  }

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
              createGroup();
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
                        getImage().then((value) {
                          print(_selectedImage);
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Group Name ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("*",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Group Name...",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) {
                              this._createGroupModel.groupName = val;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Quiz Size ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("*",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
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
                              this._createGroupModel.quizSize = int.parse(val);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Subjects ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("*",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: buildChoosingSubjects(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildChoosingSubjects() {
    final subjectsText = _subjects.map((subject) => subject.name).join(', ');
    final ids = _subjects.map((subject) => subject.id);
    final onTap = () async {
      final subjects = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectPage(
            subjects: List.of(this._subjects),
          ),
        ),
      );
      if (subjects == null) return;
      setState(() => this._subjects = subjects);
    };
    return buildSubjectPicker(
      title: 'SelectSubjects',
      child: _subjects.isEmpty
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
