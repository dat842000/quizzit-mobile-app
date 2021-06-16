import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/search_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:intl/intl.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatefulWidget {
  final List<Group> itemsData = [
    Group(
        "Math Group",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/90954431_1582148621924471_7611655305281142784_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=825194&_nc_ohc=jgOg1-97daQAX--nxb2&_nc_ht=scontent-sin6-3.xx&oh=e405c37b9c016426c7052451ae7a161d&oe=60D913F0",
        DateTime.now(),
        ["Ly", "Hoa"],
        12,
        0,
        0),
    Group(
        "Physics Group",
        "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.18169-9/28379844_10156181840423126_2758359348106619364_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=825194&_nc_ohc=P2ycqfZHNUUAX-pPnZK&_nc_ht=scontent.fsgn5-6.fna&oh=cafbc3bcc1801c35a918915e1ce4011f&oe=60DB12E0",
        DateTime.now(),
        ["Ly", "Hoa"],
        10,
        1,
        1),
    Group(
        "PRJ303_Survice",
        "https://image.shutterstock.com/image-vector/maths-hand-drawn-vector-illustration-260nw-460780561.jpg",
        DateTime.now(),
        ["Ly", "Hoa"],
        16,
        1,
        1),
    Group(
        "Math Group",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVI19c8BieX1brqjOdMKlt1mRINsKuLK6JA&usqp=CAU",
        DateTime.now(),
        ["Ly", "Hoa"],
        20,
        1,
        1),
    Group(
        "Math Group",
        "https://tr-images.condecdn.net/image/V2n9Jj303ye/crop/405/f/pamukkale-turkey-gettyimages-1223155251.jpg",
        DateTime.now(),
        ["Ly", "Hoa"],
        14,
        0,
        2),
  ];

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
                  return CreateGroupScreen();
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
      width: 60.0,
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
                      child: CachedNetworkImage(
                        imageUrl: group.imgUrl,
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
                                ContinueTag()
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
