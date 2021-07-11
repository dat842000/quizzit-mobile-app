import 'package:flutter/material.dart';
import 'package:quizzit/Screens/CreateGroup/create_group_screen.dart';
import 'package:quizzit/Screens/JoinGroup/join_group_screen.dart';
import 'package:quizzit/constants.dart';

class BuildSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25.0,
          right: 27.0,
          left: 27.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create A Group",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF0D253F),
                      fontWeight: FontWeight.w600),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                    color: Color(0xFF309398),
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.people,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: (Text(
                'CREATE A NEW ONE',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0D253F),
                    fontWeight: FontWeight.w600),
              )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: 250,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: FlatButton(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateGroupScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CREATE GROUP',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            ClipOval(
              child: Image.asset(
                "assets/icons/groups.png",
                height: size.height * 0.4,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: (Text(
                'OR JOIN A GROUP YOU KNOW',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0D253F),
                    fontWeight: FontWeight.w600),
              )),
            ),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(29),
              ),
              child: FlatButton(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JoinGroupScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'JOIN A GROUP',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
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
