import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/search_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:flutter_auth/global/ListUsers.dart' as list;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';

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
  String query = "";
  bool isAdmin = true;
  Group group;
  String title = "Members";
  List<User> newList = list.listUser;
  List<User> temp = list.listUser;
  List<User> itemsData = [];

  _BodyState({required this.group}) {
    // if (globals.userId == group.userCreate) isAdmin = true;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    itemsData = [...temp];
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          isAdmin ? "New Requests" : title,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        actions: widget.group.userCreate == globals.userId
            ? <Widget>[
                PopupMenuButton<String>(
                  icon: Icon(
                    FontAwesomeIcons.bars,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.adminManageUser.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ]
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(child: buildSearch(), color: Colors.white,),
          ),
          Expanded(
            child: ListUser(newList, isAdmin, setState: () {
              setState(() {});
            }),
          ),
        ],
      ),
    );
  }
  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'User Name',
    onChanged: searchUser,
  );

  void searchUser(String query) {
    var listUsers = [...itemsData];
    if (!query.isEmpty) {
      listUsers = newList.where((user) {
        final nameLower = user.name.toLowerCase();
        // final authorLower = group..toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
        // || authorLower.contains(searchLower);
      }).toList();
    }
    setState(() {
      this.query = query;
      this.newList = [...listUsers];
    });
  }

  void choiceAction(String choice) {
    if (choice == "Members") {
      title = "Members";
      isAdmin = false;
    } else {
      title = "New Requests";
      isAdmin = true;
    }
    setState(() {});
  }
}

class ListUser extends StatelessWidget {
  List<User> listUser;
  bool isAdmin;
  Function() setState;

  ListUser(this.listUser, this.isAdmin, {required this.setState});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<User> temp = [...listUser];
    // temp.sublist(3, listUser.length);
    return SingleChildScrollView(
        child:
        // !isAdmin
            //     ? Column(
            //         children: [
            //           UserCard(temp[0], Colors.white, 1, isAdmin, listUser, "",
            //               setState: setState),
            //           UserCard(temp[1], Colors.white, 2, isAdmin, listUser, "",
            //               setState: setState),
            //           UserCard(temp[2], Colors.white, 3, isAdmin, listUser, "",
            //               setState: setState),
            //           ...List.generate(
            //               temp.length - 3,
            //               (index) => Column(
            //                     children: [
            //                       UserCard(temp[index + 3], Colors.white, index + 4,
            //                           isAdmin, listUser, "",
            //                           setState: setState)
            //                     ],
            //                   )),
            //         ],
            //       )
            //     :
            Column(children: [
                ...List.generate(
                    listUser.length,
                    (index) => index != 1
                        ? Column(
                            children: [
                              UserCard(
                                  temp[index],
                                  Colors.white,
                                  index,
                                  isAdmin,
                                  listUser,
                                  "Can i choice, I really love this group",
                                  setState: setState)
                            ],
                          )
                        : Column(
                            children: [
                              UserCard(
                                  temp[index],
                                  Colors.white,
                                  index,
                                  isAdmin,
                                  listUser,
                                  "Can i choice, I really love this group",
                                  setState: setState)
                            ],
                          )),
              ]));
  }
}

class UserCard extends StatelessWidget {
  User user;
  Color? color;
  int index;
  bool isAdmin;
  Function() setState;
  List<User> listUser;
  String reason;

  UserCard(this.user, this.color, this.index, this.isAdmin, this.listUser,
      this.reason,
      {required this.setState});
  void choiceAction(String choice) {
    if (choice == "") {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isAdmin
        ? Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Approve',
                color: Colors.lightBlue,
                icon: Icons.check,
                onTap: () {},
              ),
              IconSlideAction(
                caption: 'Decline',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () {
                  listUser.removeAt(index);
                  setState();
                },
              )
            ],
            child: Container(
                height: 100,
                decoration: new BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    color: color,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black54))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.urlImg)),
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
              IconSlideAction(
                caption: 'Kick',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () {
                  listUser.removeAt(index);
                  setState();
                },
              )
            ],
            child: Container(
                height: 100,
                decoration: new BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    color: color,
                    border: Border(
                        bottom:
                            BorderSide(color: Theme.of(context).dividerColor))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.urlImg)),
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
                        trailing: PopupMenuButton<String>(
                          icon: Icon(
                            FontAwesomeIcons.ellipsisH,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return Constants.reportPost
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                  value: choice,
                                  child: report(
                                    text: "Report",
                                  ));
                            }).toList();
                          },
                        ),
                      ),
                    ])));
  }
}
class report extends StatelessWidget {
  String text;
  report({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.redAccent),
              ),
              Icon(
                FontAwesomeIcons.exclamation,
                color: Colors.redAccent,
              )
            ],
          ),
        )
    );
  }
}
