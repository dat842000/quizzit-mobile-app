import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  _BodyState createState() => _BodyState(group: group);
}

class _BodyState extends State<Body> {
  bool isAdmin = false;
  Group group;
  String choice = "Members";
  int activeMenu = 0;
  List menu = ["Members", "Requests", "Banned"];

  _BodyState({required this.group}) {
    if (group.currentMemberStatus == 3) isAdmin = true;
  }

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
        "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
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
        "Hiep",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-1/s320x320/151666982_1791768614330490_6210226921179657624_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=7206a8&_nc_ohc=riZEuLzCWZwAX8Hy7zS&_nc_ht=scontent-sin6-2.xx&tp=7&oh=113619bd478b4fbc8944260a56e48b14&oe=60C8BF22",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        5,
        "Duong",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/186506523_101122005513976_9062523887582103932_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=0Tw1gI98TdwAX_qBMU4&_nc_oc=AQl4sbDLY_GLlKPDP_R8JE1oJ8ICzV70rl7rsYY3QTX2U5VdL7b0r0DLuedw1teqpBi6qWhviKJwoWcc_UE-ZKq5&_nc_ht=scontent-sin6-3.xx&oh=f17fb5d6e0d0f06ebfaeca8ec3511b74&oe=60C8FF2B",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        6,
        "Thang",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-1/p320x320/190761240_1588435718026211_7193804840421773918_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=7206a8&_nc_ohc=P64l9l9JL9cAX-4Pwc9&_nc_oc=AQmD0dyAZT1VLGrbUnlf4qhXsPjlyxrIt1lGaILImtdiupH7L3YSdGptjQM6UKo9ewE&_nc_ht=scontent-sin6-2.xx&tp=6&oh=8e04e4f955df9d7275a931b7df36df5e&oe=60C9B03E",
        "Vinh@gmail.com",
        DateTime.now()),
    User(
        7,
        "Oc cho",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-9/87029316_1110067389336629_8333488988178350080_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=174925&_nc_ohc=lFZvBWwCh8UAX_N05NZ&_nc_ht=scontent-sin6-2.xx&oh=956c79c35bf60c3f089ea07ee6d4bdbb&oe=60CA1861",
        "Vinh@gmail.com",
        DateTime.now()),
  ];

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
                padding: EdgeInsets.only(
                    left: 20.0, top: 35.0, bottom: 35, right: 15),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Color(0xff75c7c9),
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
              isAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(menu.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                activeMenu = index;
                                choice = menu[index];
                              });
                            },
                            child: activeMenu == index
                                ? ElasticIn(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff75c7c9),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 8,
                                            bottom: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              menu[index],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 8,
                                          bottom: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            menu[index],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      }),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff75c7c9),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  menu[0],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          ListUser(users, choice, setState: setState),
        ],
      ),
    ));
  }
}

class ListUser extends StatelessWidget {
  List<User> listUser;
  String choice;
  StateSetter setState;

  ListUser(this.listUser, this.choice, {required this.setState});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<User> temp = [...listUser];
    return SingleChildScrollView(
        child: choice == "Members"
            ? Column(children: [
                ...List.generate(
                    listUser.length,
                    (index) => Column(
                          children: [
                            UserCard(
                                temp[index],
                                Colors.white,
                                index,
                                choice,
                                listUser,
                                "Can i choice, I really love this group",
                                setState)
                          ],
                        )),
              ])
            : choice == "Requests"
                ? Column(
                    children: [
                      ...List.generate(
                          temp.length,
                          (index) => Column(
                                children: [
                                  UserCard(temp[index], Colors.white, index + 1,
                                      choice, listUser, "", setState)
                                ],
                              )),
                    ],
                  )
                : Column(
                    children: [
                      ...List.generate(
                          temp.length,
                          (index) => Column(
                                children: [
                                  UserCard(temp[index], Colors.white, index + 1,
                                      choice, listUser, "123", setState)
                                ],
                              )),
                    ],
                  ));
  }
}

class UserCard extends StatelessWidget {
  User user;
  Color? color;
  int index;
  String choice;
  StateSetter _setState;
  List<User> listUser;
  String reason;

  UserCard(this.user, this.color, this.index, this.choice, this.listUser,
      this.reason, this._setState);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return choice == "Members"
        ? Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      Text(
                        "Banned",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
            child: Container(
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: DottedBorder(
                          color: Colors.black,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(25),
                          strokeWidth: 1,
                          dashPattern: [4],
                          child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(user.urlImg)),
                        ),
                        title: Text(user.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('#${index}',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ])))
        : choice == "Requests"
            ? Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            "Approve",
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        listUser.removeAt(index);
                        _setState;
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                          Text(
                            "Decline",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                child: Container(
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: DottedBorder(
                              color: Colors.black,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(25),
                              strokeWidth: 1,
                              dashPattern: [4],
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(user.urlImg)),
                            ),
                            title: Text(user.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(reason,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                          // Divider(color: Colors.grey[600],)
                        ])),
              )
            : Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_up,
                            color: Color(0xff75c7c9),
                          ),
                          Text(
                            "UnBanned",
                            style: TextStyle(
                                color: Color(0xff75c7c9),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                child: Container(
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: DottedBorder(
                              color: Colors.black,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(25),
                              strokeWidth: 1,
                              dashPattern: [4],
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(user.urlImg)),
                            ),
                            title: Text(user.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text('#${index}',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ])));
  }
}
