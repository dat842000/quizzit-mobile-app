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
  _BodyState({required this.group}){
    if (globals.userId == group.owner.id) isAdmin = true;
  }

  List<User> users = [
    User(2,
        "Ojisan",
        "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
        "haseoleonard@gmail.com",
      DateTime.now()
    ),
    User(1,
        "Dat Nguyen",
        "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
        "dnn8420@gmail.com",
        DateTime.now()
    ),
    User(3,
        "Vinh",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/62118713_2352579395000621_7361899465210331136_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_aid=0&_nc_ohc=oJWBxQjFJMQAX_f7b-f&_nc_ht=scontent-sin6-3.xx&oh=f8a35487883d02632eaff1d2ed88cb17&oe=60E7D745",
        "Vinh@gmail.com",
        DateTime.now()
    ),
    User(4,
        "Hiep",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-1/s320x320/151666982_1791768614330490_6210226921179657624_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=7206a8&_nc_ohc=riZEuLzCWZwAX8Hy7zS&_nc_ht=scontent-sin6-2.xx&tp=7&oh=113619bd478b4fbc8944260a56e48b14&oe=60C8BF22",
        "Vinh@gmail.com",
        DateTime.now()
    ),
    User(5,
        "Duong",
        "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/186506523_101122005513976_9062523887582103932_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=0Tw1gI98TdwAX_qBMU4&_nc_oc=AQl4sbDLY_GLlKPDP_R8JE1oJ8ICzV70rl7rsYY3QTX2U5VdL7b0r0DLuedw1teqpBi6qWhviKJwoWcc_UE-ZKq5&_nc_ht=scontent-sin6-3.xx&oh=f17fb5d6e0d0f06ebfaeca8ec3511b74&oe=60C8FF2B",
        "Vinh@gmail.com",
        DateTime.now()
    ),
    User(6,
        "Thang",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-1/p320x320/190761240_1588435718026211_7193804840421773918_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=7206a8&_nc_ohc=P64l9l9JL9cAX-4Pwc9&_nc_oc=AQmD0dyAZT1VLGrbUnlf4qhXsPjlyxrIt1lGaILImtdiupH7L3YSdGptjQM6UKo9ewE&_nc_ht=scontent-sin6-2.xx&tp=6&oh=8e04e4f955df9d7275a931b7df36df5e&oe=60C9B03E",
        "Vinh@gmail.com",
        DateTime.now()
    ),
    User(7,
        "Oc cho",
        "https://scontent-sin6-2.xx.fbcdn.net/v/t1.6435-9/87029316_1110067389336629_8333488988178350080_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=174925&_nc_ohc=lFZvBWwCh8UAX_N05NZ&_nc_ht=scontent-sin6-2.xx&oh=956c79c35bf60c3f089ea07ee6d4bdbb&oe=60CA1861",
        "Vinh@gmail.com",
        DateTime.now()
    ),
  ];
  String title = "RANK";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
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
        actions: group.owner.id==globals.userId
        // widget.group.userCreate == globals.userId
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
      body: ListUser(users, isAdmin, setState: () {
        setState(() {});
      }),
    );
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
    temp.sublist(3, listUser.length);
    return SingleChildScrollView(
        child: !isAdmin
            ? Column(
                children: [
                  UserCard(temp[0], Colors.white, 1, isAdmin, listUser, "",
                      setState: setState),
                  UserCard(temp[1], Colors.white, 2, isAdmin, listUser, "",
                      setState: setState),
                  UserCard(temp[2], Colors.white, 3, isAdmin, listUser, "",
                      setState: setState),
                  ...List.generate(
                      temp.length - 3,
                      (index) => Column(
                            children: [
                              UserCard(temp[index + 3], Colors.white, index + 4,
                                  isAdmin, listUser, "",
                                  setState: setState)
                            ],
                          )),
                ],
              )
            : Column(children: [
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
      this.reason, {required this.setState});

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
                      ),
                    ])));
  }
}
