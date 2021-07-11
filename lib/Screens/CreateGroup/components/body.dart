import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quizzit/Screens/CreateGroup/components/subject_page.dart';
import 'package:quizzit/Screens/UserViewGroup/user_view_group.dart';
import 'package:quizzit/components/navigate.dart';
import 'package:quizzit/components/show_photo_menu.dart';
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/group/CreateGroupModel.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/problemdetails/ProblemDetails.dart';
import 'package:quizzit/models/subject/Subject.dart';
import 'package:quizzit/utils/ApiUtils.dart';
import 'package:quizzit/utils/FirebaseUtils.dart';
import 'package:quizzit/utils/snackbar.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CreateGroupModel _createGroupModel =
      new CreateGroupModel("", 10, null, List.empty(growable: true));
  File? _selectedImage;
  List<Subject> _subjects = [];
  double _progress = 0;
  StateSetter? _setState;

  Future<Group> createGroup() async {
    //TODO CreateGroup
    String? image;
    if (this._selectedImage != null) {
      image = await FirebaseUtils.uploadImage(
        _selectedImage!,
        uploadLocation: UploadLocation.Groups,
        whileUpload: (byteTransfered, totalBytes) {
          // print(byteTransfered);
          _setState!(() {
            _progress = byteTransfered.toDouble() / totalBytes.toDouble();
          });
        },
        onError: (Object? error) {
          log(error!.toString());
        },
      );
    }
    if (this._subjects.isNotEmpty)
      _subjects.forEach((e) => this._createGroupModel.subjectIds.add(e.id));
    this._createGroupModel.image = image;
    var response =
        await fetch(Host.groups, HttpMethod.POST, data: this._createGroupModel);
    var jsonRes = json.decode(response.body);
    log(response.body);
    if (response.statusCode.isOk()) {
      var newGroup = Group.fromJson(jsonRes);
      return newGroup;
    } else {
      return Future.error(ProblemDetails.fromJson(jsonRes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigate.popToDashboard(context);
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              EasyLoading.show(
                  status: 'Đang tạo...', maskType: EasyLoadingMaskType.black);
              createGroup().then((value) {
                showSuccess(text: "Tạo group thành công", context: context);
                Navigate.push(context, UserViewScreen(value));
                EasyLoading.dismiss();
              }).catchError((onError) {
                showError(
                    text: (onError as ProblemDetails).title!, context: context);
              });
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  buildPhotoPickerMenu(context, onPick: (pickedImage) {
                    setState(() {
                      this._selectedImage = pickedImage;
                    });
                  });
                },
                child: _selectedImage != null
                    ? Stack(children: [
                        Container(
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
                        ),
                        Positioned(
                            top: 10,
                            right: 25,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = null;
                                  });
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.redAccent,
                                  size: 20,
                                )))
                      ])
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
                  buildChoosingSubjects(),
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
    // final ids = _subjects.map((subject) => subject.id);
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
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey, width: 1)),
            margin: EdgeInsets.zero,
            child: child,
          ),
        ],
      );
}
