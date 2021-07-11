// ignore: import_of_legacy_library_into_null_safe
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/Screens/ListUser/components/ListUser.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/member/Member.dart';

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
  Group group;
  int status = 2;
  List menu = ["", "Requests", "Members", "", "", "Banned"];

  _BodyState({required this.group});

  List<Member> users = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
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
              FirebaseAuth.instance.currentUser!.uid ==
                      group.owner.id.toString()
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(menu.length, (index) {
                        return menu[index] != ""
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  right: 0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      status = index;
                                      // choice = menu[index];
                                    });
                                  },
                                  child: status == index
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
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              )
                            : Container();
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
                                  menu[2],
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
          ListUser(widget.group, status),
        ],
      ),
    );
  }
}
