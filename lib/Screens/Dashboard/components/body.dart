import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreateGroup/create_group_screen.dart';
import 'package:flutter_auth/Screens/Dashboard/components/devider.dart';
import 'package:flutter_auth/components/navigation_drawer_widget.ws.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xffe4e6eb),
        iconTheme: IconThemeData(color: kPrimaryColor),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(FontAwesomeIcons.sortAmountDown, color: kPrimaryColor, size: 20,),
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
      drawer: NavigationDrawer(),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            GroupsTitle(
              imgUrl:
                  'https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/90954431_1582148621924471_7611655305281142784_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=825194&_nc_ohc=jgOg1-97daQAX--nxb2&_nc_ht=scontent-sin6-3.xx&oh=e405c37b9c016426c7052451ae7a161d&oe=60D913F0',
              title: 'Math Group',
              description: 'Toan',
            ),
            GroupsTitle(
              imgUrl:
                  'https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.18169-9/28379844_10156181840423126_2758359348106619364_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=825194&_nc_ohc=P2ycqfZHNUUAX-pPnZK&_nc_ht=scontent.fsgn5-6.fna&oh=cafbc3bcc1801c35a918915e1ce4011f&oe=60DB12E0',
              title: 'Physics Group',
              description: 'Ly',
            ),
            GroupsTitle(
              imgUrl:
                  'https://image.shutterstock.com/image-vector/maths-hand-drawn-vector-illustration-260nw-460780561.jpg',
              title: 'PRJ303_Survice',
              description: 'Hoa',
            ),
            GroupsTitle(
              imgUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVI19c8BieX1brqjOdMKlt1mRINsKuLK6JA&usqp=CAU',
              title: 'Math Group',
              description: 'none',
            ),
            GroupsTitle(
              imgUrl:
                  'https://tr-images.condecdn.net/image/V2n9Jj303ye/crop/405/f/pamukkale-turkey-gettyimages-1223155251.jpg',
              title: 'Math Group',
              description: 'none',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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

  void choiceAction(String choice) {}
}

class Tag extends StatelessWidget {
  String text;

  Tag({@required this.text});

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
  String text;

  ContinueTag({@required this.text});

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
        text,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class GroupsTitle extends StatelessWidget {
  String imgUrl, title, description;

  GroupsTitle(
      {@required this.imgUrl,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: <Widget>[
          Container(
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
                    imageUrl: imgUrl,
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
                          title,
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
                            Tag(
                              text: description,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Tag(
                              text: 'Ly',
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ContinueTag(
                              text: '...',
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xfff3f4fb),
                        height: 0,
                        thickness: 2,
                      ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 12,
                          bottom: 12,
                          right: 5,
                        ),
                        child: Wrap(
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
                                "Tue 4 February 2021",
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
                                "18",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
