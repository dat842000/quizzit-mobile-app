import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navigation_drawer_widget.ws.dart';
import 'package:flutter_auth/constants.dart';
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
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kPrimaryColor),
        actions: <Widget>[
          PopupMenuButton<String>(
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
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 30,
            color: kPrimaryColor,
          ),
        ),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            GroupsTitle(
              imgUrl:
                  'https://holidaysarthi.com/wp-content/uploads/elementor/thumbs/Cheap-tour-Nha-Trang-10-most-beautiful-places-to-visit-vietnam-holiday-destination-oelwps02gica3afv2ixdd23kz1caenta0b7mtiex5w.jpg',
              title: 'Math Group',
              authorName: 'Dat Nguyen',
              description: 'none',
            ),
            GroupsTitle(
              imgUrl:
                  'https://holidaysarthi.com/wp-content/uploads/elementor/thumbs/Cheap-tour-Phu-Quoc-Island-10-most-beautiful-places-to-visit-vietnam-holiday-destination-oely2hywpd1bvno4kl37lrhpg177dv8epgjobu6an8.jpg',
              title: 'Math Group',
              authorName: 'Dat Nguyen',
              description: 'none',
            ),
            GroupsTitle(
              imgUrl:
                  'https://d2rdhxfof4qmbb.cloudfront.net/wp-content/uploads/20180912154048/British-rural.jpg',
              title: 'Math Group',
              authorName: 'Dat Nguyen',
              description: 'none',
            ),
            GroupsTitle(
              imgUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVI19c8BieX1brqjOdMKlt1mRINsKuLK6JA&usqp=CAU',
              title: 'Math Group',
              authorName: 'Dat Nguyen',
              description: 'none',
            ),
            GroupsTitle(
              imgUrl:
                  'https://tr-images.condecdn.net/image/V2n9Jj303ye/crop/405/f/pamukkale-turkey-gettyimages-1223155251.jpg',
              title: 'Math Group',
              authorName: 'Dat Nguyen',
              description: 'none',
            ),
            GroupCreate(),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {}
}

class GroupCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {},
      ),
    );
  }
}

class GroupsTitle extends StatelessWidget {
  String imgUrl, title, description, authorName;

  GroupsTitle(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width - 50,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    width: MediaQuery.of(context).size.width - 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        authorName,
                        style: TextStyle(color: Colors.white),
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
