import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GroupInfo/components/Tags.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/UpdateGroup/update_screen.dart';
import 'package:flutter_auth/global/Subject.dart' as state;
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/group/GroupInfo.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatefulWidget {
  Group group;
  Function update;
  List<User> users = [
    User(
        2,
        "Ojisan",
        "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
        "haseoleonard@gmail.com",
        DateTime.now()),
    User(
        1,
        "Dat Nguyen",
        "https://scontent-sin6-4.xx.fbcdn.net/v/t1.6435-9/204333890_2947606698848046_2471054969970351329_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=wKpYnFT5V8YAX_qt8ui&_nc_ht=scontent-sin6-4.xx&oh=4dac0af4f5e9ab3ce4a39fd51d3d5e04&oe=60EA4BD2",
        "dnn8420@gmail.com",
        DateTime.now()),
    User(
        3,
        "Vinh",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/62118713_2352579395000621_7361899465210331136_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_aid=0&_nc_ohc=oJWBxQjFJMQAX_f7b-f&_nc_ht=scontent-sin6-3.xx&oh=f8a35487883d02632eaff1d2ed88cb17&oe=60E7D745",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        4,
        "Thu",
        "https://scontent-xsp1-3.xx.fbcdn.net/v/t1.6435-9/164801830_1406846849648179_7728545225047973747_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=WXsqNr6PmEoAX96DHDT&_nc_ht=scontent-xsp1-3.xx&oh=633acdc514a53143c78866811bc72bc2&oe=60E87CCE",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        5,
        "Duong",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/178775876_2830446380551791_7283789377379465271_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=2Tlvo_6lcVcAX-B7D0z&_nc_ht=scontent-sin6-3.xx&oh=92b259c47fd1581d8b98e2b2f09214ee&oe=60E9A800",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        6,
        "Thang",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-9/190761240_1588435718026211_7193804840421773918_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=3OoipRXqnUYAX8_eRZK&_nc_oc=AQlOSGuz5HhukbyLTqzFwn89gDvAAcX5frfyVk0iR_G6KTNmzgHefzBLY7bsIPcBaMI&tn=UXEnyOPwjpakM2kE&_nc_ht=scontent-sin6-2.xx&oh=640ee11d7bbb778f5d30858f96b97193&oe=60E99267",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        7,
        "Oc cho",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-9/87029316_1110067389336629_8333488988178350080_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=174925&_nc_ohc=lFZvBWwCh8UAX_N05NZ&_nc_ht=scontent-sin6-2.xx&oh=956c79c35bf60c3f089ea07ee6d4bdbb&oe=60CA1861",
        "Vinh@gmail.com",
        DateTime.now()),
  ];

  Future<GroupInfo> _getGroupInfo() async {
    var response =
        await fetch(Host.updateGroup(groupId: group.id), HttpMethod.GET);
    if (response.statusCode.isOk()) {
      var group = GroupInfo.fromJson(json.decode(response.body));
      this.group = group;
      return group;
    } else
      throw new Exception(response.body);
  }

  Body(this.group, this.update);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<GroupInfo> groupInfoFuture;

  @override
  void initState() {
    super.initState();
    groupInfoFuture = widget._getGroupInfo();
    widget.update = (newGroup) => setState(() {widget.group = newGroup;});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<GroupInfo>(
            future: groupInfoFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, top: 35.0, bottom: 35),
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
                                  onPressed: () {
                                    Navigator.pop(context);
                                    state.setState[0].call(widget.group);
                                    },
                                ),
                              ),
                            ),
                          ),
                          Text(
                            // snapshot.data!.name,
                            widget.group.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: widget.group.currentMemberStatus == 3
                                ? InkWell(
                                    onTap: () {
                                          Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => UpdateGroupScreen(
                                            widget.group, widget.update),
                                      ));
                                    },
                                    child: Icon(Icons.edit))
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: SizedBox(
                                      width: 10,
                                    ),
                                  ),
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
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: Stack(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.image ?? "",
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ])),
                      buildSubjects(context, snapshot.data!),
                      Container(
                        padding: EdgeInsets.only(
                            left: 35, right: 35, top: 10, bottom: 5),
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
                              "Ranking",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [...buildRankings(widget.users)]),
                      Container(
                        padding: EdgeInsets.only(
                            left: 35, right: 35, top: 10, bottom: 5),
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildInformation(context, snapshot.data!),
                          SizedBox(
                            width: 10,
                          ),
                          widget.group.currentMemberStatus == 3
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => UpdateGroupScreen(
                                          snapshot.data!, widget.update),
                                    ));
                                  },
                                  child: buildSettings(context, snapshot.data!))
                              : buildSettings(context, snapshot.data!),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

List<Widget> buildRankings(List<User> users) {
  List<Widget> lists = [];
  for (var index = 0; index < 6; index++) {
    switch (index) {
      case 0:
        lists.add(
            userRankingColumn(90, Color(0xff83bb98), index + 1, users[index]));
        break;
      case 1:
        lists.add(
            userRankingColumn(70, Color(0xfffb8b8c), index + 1, users[index]));
        break;
      case 2:
        lists.add(
            userRankingColumn(60, Color(0xfff6ba3f), index + 1, users[index]));
        break;
      case 3:
        lists.add(
            userRankingColumn(50, Color(0xff50bfeb), index + 1, users[index]));
        break;
      case 4:
        lists.add(
            userRankingColumn(40, Color(0xff83bb98), index + 1, users[index]));
        break;
      case 5:
        lists.add(
            userRankingColumn(30, Color(0xfffb8b8c), index + 1, users[index]));
        break;
    }
  }
  return lists;
}

Widget userRankingColumn(double height, Color color, int rank, User user) =>
    Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          // Text(
          //   user.name,
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
          // ),
          SizedBox(
            height: 5,
          ),
          DottedBorder(
            color: Colors.black,
            borderType: BorderType.RRect,
            radius: Radius.circular(25),
            strokeWidth: 1,
            dashPattern: [4],
            child: CircleAvatar(
                radius: 10, backgroundImage: NetworkImage(user.urlImg)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 37,
            height: height,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black87, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("#$rank"),
              ),
            ),
          )
        ],
      ),
    );

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

Widget buildInformation(BuildContext context, GroupInfo group) => Container(
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
          child: buildAboutInfo(Icons.info, group),
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

Widget buildAboutInfo(IconData iconTitle, GroupInfo group) => Container(
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
                Text("Posts: ${group.totalPost}"),
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
                Text("Users: ${group.totalMem}"),
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
