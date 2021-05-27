import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navigation_drawer_widget.ws.dart';
import 'package:flutter_auth/constants.dart';

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
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: kPrimaryColor,
            ),
            tooltip: 'Sort group',
            onPressed: () {},
          ),
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
    );
  }
}
