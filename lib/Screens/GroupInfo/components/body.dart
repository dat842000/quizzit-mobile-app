import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GroupInfo/components/Tags.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/UpdateGroup/update_screen.dart';

import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatefulWidget {
  final Group group;
  Function update;

  Body(this.group, this.update);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              Text(
                widget.group.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: widget.group.currentMemberStatus == 3
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UpdateGroupScreen(widget.group, widget.update),
                          ));
                        },
                        child: Icon(Icons.edit))
                    : null,
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black54, width: 2)),
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: widget.group.image ?? "",
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])),
          buildSubjects(context, widget.group),
          Container(
            padding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 5),
            child: Divider(
              height: 18,
              thickness: 2,
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildInformation(context),
              SizedBox(
                width: 10,
              ),
              widget.group.currentMemberStatus == 3
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateGroupScreen(widget.group, widget.update),
                        ));
                      },
                      child: buildSettings(context, widget.group))
                  : buildSettings(context, widget.group),
            ],
          )
        ],
      ),
    ));
  }
}

Widget buildSubjects(BuildContext context, Group group) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subjects",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 27,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: group.subjects.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                        children: [
                          Tag(text: group.subjects[index].name),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      )),
            ),
          ],
        ),
      ),
    );

Widget buildInformation(BuildContext context) => Container(
      width: 160,
      height: 166,
      child: Stack(children: [
        Positioned(
            top: 6,
            left: 6,
            width: 154,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff78c5c5),
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: Colors.black54, width: 2)),
            )),
        Container(
          width: 154,
          height: 160,
          decoration: BoxDecoration(
              color: Color(0xffeaf7f7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black54, width: 2)),
          child: buildAboutInfo(Icons.info),
        ),
      ]),
    );

Widget buildSettings(BuildContext context, Group group) => Container(
      width: 160,
      height: 166,
      child: Stack(children: [
        Positioned(
            top: 6,
            left: 6,
            width: 154,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffb2cc84),
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(color: Colors.black54, width: 2)),
            )),
        Container(
          width: 154,
          height: 160,
          decoration: BoxDecoration(
              color: Color(0xfff4f8ec),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black54, width: 2)),
          child: buildAboutSettings(Icons.settings, group),
        ),
      ]),
    );

Widget buildAboutInfo(IconData iconTitle) => Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DottedBorder(
                  color: Colors.black,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  strokeWidth: 1,
                  dashPattern: [4],
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(
                        iconTitle,
                        color: Color(0xff77c6c6),
                      ))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.file),
                SizedBox(
                  width: 15,
                ),
                Text("Posts: 6"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.users),
                SizedBox(
                  width: 15,
                ),
                Text("Users: 30"),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildAboutSettings(IconData iconTitle, Group group) => Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DottedBorder(
                  color: Colors.black,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  // padding: EdgeInsets.all(10),
                  strokeWidth: 1,
                  dashPattern: [4],
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Icon(
                        iconTitle,
                        color: Color(0xffbbda86),
                      ))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.font),
                SizedBox(
                  width: 15,
                ),
                Text(group.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.question),
                SizedBox(
                  width: 15,
                ),
                Text("Quiz size: " + group.quizSize.toString()),
              ],
            ),
          ),
        ],
      ),
    );
