import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/show_photo_menu.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/group/UpdateGroupModel.dart';
import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:flutter_auth/utils/FirebaseUtils.dart';
import 'package:flutter_auth/utils/snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'subject_page.dart';

class Body extends StatefulWidget {
  final Group group;
  Function update;

  Body(this.group, this.update);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UpdateGroupModel? _updateGroupModel;
  File? _selectedImage;
  bool _isLoading = false;
  bool isDelete = false;
  List<Subject> _subjects = [];

  @override
  void initState() {
    _subjects = widget.group.subjects;
    _updateGroupModel = UpdateGroupModel(
        widget.group.name, widget.group.quizSize, widget.group.image, []);
  } // _BodyState({required Group group});

  Future<void> updateGroup() async {
    //TODO CreateGroup
    String? image;
    if (this._selectedImage != null) {
      image = await FirebaseUtils.uploadImage(
        _selectedImage!,
        uploadLocation: UploadLocation.Groups,
        whileUpload: (byteTransfered, totalBytes) {},
        onError: (error) {},
      );
    } else if (isDelete == false) {
      image = widget.group.image;
    }
    print(_subjects);
    if (this._subjects.isNotEmpty) {
      _subjects.forEach((e) => this._updateGroupModel!.subjectIds.add(e.id));
    }
    this._updateGroupModel!.image = image;
    var response = await fetch(
        Host.updateGroup(groupId: widget.group.id), HttpMethod.PUT,
        data: this._updateGroupModel);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk()) {
      var newGroup = Group.fromJson(jsonRes);

      widget.group.name = newGroup.name;
      widget.update();
      showSuccess(text: "Cập nhật group thành công", context: context);
    } else {
      ProblemDetails problem = ProblemDetails.fromJson(jsonRes);
      // showOkAlert(context, "Create Failed", problem.title!,
      //     onPressed: (context) => Navigate.pop(context));
      showSuccess(text: problem.title!, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Icon(
        Icons.add_a_photo,
        color: Colors.black45,
      ),
    );
    if (_selectedImage == null &&
        widget.group.image != null &&
        isDelete == false) {
      image = Stack(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 170,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.group.image ?? "",
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
      if (_selectedImage != null &&
          isDelete == false) {
        image = Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 170,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            width: MediaQuery
                .of(context)
                .size
                .width,
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
        backgroundColor: Colors.white,
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
                "Update",
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
                    status: 'Đang cập nhật...',
                    maskType: EasyLoadingMaskType.black);
                await updateGroup();
                EasyLoading.dismiss();
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
                    buildPhotoPickerMenu(context, onPick: (pickedImage) {
                      setState(() {
                        this._selectedImage = pickedImage;
                        isDelete = false;
                      });
                    });
                  },
                  child: image),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                        controller: TextEditingController(
                            text: _updateGroupModel!.groupName),
                        decoration: InputDecoration(
                          hintText: "Group Name...",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          this._updateGroupModel!.groupName = val;
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
                        controller: TextEditingController(
                            text: _updateGroupModel!.quizSize.toString()),
                        decoration: InputDecoration(
                          hintText: "Quiz Size",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          this._updateGroupModel!.quizSize = int.parse(val);
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
      final ids = _subjects.map((subject) => subject.id);
      final onTap = () async {
        final subjects = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SubjectPage(
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
          style: TextStyle(color: Colors.black87, fontSize: 17),
        ),
        trailing: Icon(Icons.arrow_drop_down, color: Colors.black87),
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
