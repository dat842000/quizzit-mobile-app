import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/SwitchGroupOption/switch_group_option.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:intl/intl.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatefulWidget {
  final List<Group> itemsData = globals.itemsData;

  @override
  _BodyState createState() => _BodyState(newList: itemsData);
}

class _BodyState extends State<Body> {
  _BodyState({
    required this.newList,
  });
  String query ="";
  List<Group> newList;
  List<Group> itemsData = [];


  @override
  Widget build(BuildContext context) {
    itemsData = [...widget.itemsData];
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xffe4e6eb),
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: InkWell(
          child: Icon(FontAwesomeIcons.userCircle),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserInfoScreen(),
            ));
          },
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              FontAwesomeIcons.sortAmountDown,
              color: kPrimaryColor,
              size: 20,
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        centerTitle: true,
        title: Wrap(
          children: <Widget>[
            Text(
              "Dash",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
              ),
            ),
            Text(
              "Board",
              style: TextStyle(
                fontSize: 30,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      // drawer: NavigationDrawer(),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: newList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GroupsTitle(
                group: newList[index],
                allGroup : newList,
                setState: () => setState((){newList[index].isJoin = 2;}),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SwitchGroupOption();
                },
              ),
            );
          },
        ),
      ),
    );
  }
  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Title or Author Name',
    onChanged: searchGroup,
  );
  void searchGroup(String query) {
    var groups = [...itemsData];
    if(!query.isEmpty) {
      groups = newList.where((group) {
        final nameLower = group.name.toLowerCase();
        // final authorLower = group..toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
        // || authorLower.contains(searchLower);
      }).toList();
    }
    setState(() {
      this.query = query;
      this.newList = [...groups];
    });
  }

  void choiceAction(String choice) {
    List<Group> temp = [];
    if (choice == Constants.own) {
      newList.forEach((element) {
        if (element.userCreate == globals.userId) temp.add(element);
      });
    } else if (choice == Constants.suggest) {
      temp = [...itemsData];
    } else if (choice == Constants.join) {
      temp = [...itemsData];
    }
    setState(() {
      newList = [...temp];
    });
  }
}

class Tag extends StatelessWidget {
  String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 80.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}

class ContinueTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 30.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class GroupsTitle extends StatelessWidget {
  Group group;
  Function() setState;
  List<Group> allGroup;

  GroupsTitle({required this.group, required this.allGroup, required this.setState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allGroup.last == group ?  const EdgeInsets.only(bottom: 45) : const EdgeInsets.only(),
      child: Center(
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserViewScreen(group)));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: 240,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: group.imgUrl.startsWith("http" , 0) ? CachedNetworkImage(
                        imageUrl: group.imgUrl,
                        height: 135,
                        width: MediaQuery.of(context).size.width - 50,
                        fit: BoxFit.cover,
                      ) : Image.file(
                        File(group.imgUrl),
                        height: 135,
                        width: MediaQuery.of(context).size.width - 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 10,
                              bottom: 0,
                            ),
                            child: Text(
                              group.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Row(
                              children: <Widget>[
                                // ignore: sdk_version_ui_as_code
                                ...List.generate(
                                    group.subjects.length,
                                    (index) => Row(
                                          children: [
                                            Tag(text: group.subjects[index]),
                                            const SizedBox(
                                              width: 5,
                                            )
                                          ],
                                        )),
                                // ContinueTag()
                              ],
                            ),
                          ),
                          Divider(
                            color: Color(0xfff3f4fb),
                            height: 0,
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 12,
                              bottom: 12,
                              right: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 14.0),
                                      child: Text(
                                        DateFormat('EEE d MMM yyyy')
                                            .format(group.createdDate),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 14.0),
                                      child: Text(
                                        group.numberMember.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: group.isJoin == 0 ? InkWell(
                                    child: Icon(FontAwesomeIcons.plusCircle, color: Colors.blue[500],),
                                    onTap: (){
                                      setState();
                                    },
                                  ) : group.isJoin == 2 ? InkWell(
                                      child: Icon(FontAwesomeIcons.clock, color: Colors.blue[500],),
                                      onTap: (){
                                        setState();
                                      },
                                    ) : null,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
