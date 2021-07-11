import 'package:flutter/material.dart';
import 'package:quizzit/constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int? _groupId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: kPrimaryColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Join",
              style: TextStyle(fontSize: 30, color: Colors.black87),
            ),
            Text(
              "Group",
              style: TextStyle(fontSize: 30, color: Colors.green),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.people,
                  color: kPrimaryColor,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
            ClipOval(
              child: Image.asset(
                "assets/icons/join.jpg",
                height: size.height * 0.4,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "GROUP CODE",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0D253F),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "1023",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => this._groupId = int.parse(val),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8.0),
                    child: Column(
                      children: [
                        Text(
                          "INVITE CODE SHOULD LOOK LIKE",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0D253F),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "1023",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF0D253F),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: EdgeInsets.only(right: 20),
              width: 180,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: FlatButton(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {
                  if (this._groupId != null) {
                    // Navigate.push(context, destination)
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'JOIN GROUP',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
