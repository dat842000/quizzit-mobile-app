import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/constants.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name ='Nguyen Phuc Dat';
    final email = 'dnn8420@gmail.com';
    final urlImage = 'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/86631281_100209424910667_7473377544696233984_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=cnAeImA5r5YAX_ZkoI8&_nc_ht=scontent-hkg4-1.xx&oh=151d3abe8e741608ed17b485871f919f&oe=60D3D40A';
    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
            ),
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Dashboard',
              icon: Icons.filter,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Update',
              icon: Icons.update,
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Quiz',
              icon: Icons.message,
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Change Password',
              icon: Icons.settings,
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildHeader({
    String name,
    String urlImage,
    String email,
    VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      );
  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
        break;
    }
  }
}
