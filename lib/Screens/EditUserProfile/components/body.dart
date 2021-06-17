import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditUserProfile/components/birthday_edit_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/textfield_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/User.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static User user = User(
      1,
      "Dat Nguyen",
      "https://scontent-xsp1-2.xx.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=o7u6HzTD-XMAX-k52z6&_nc_ht=scontent-xsp1-2.xx&oh=aa00602c45fc35d0e12abc438d2a8dcb&oe=60CE7C39",
      "dnn8420@gmail.com",
      DateTime.now());
  DateTime _birthday = user.dateOfBirth;

  void setBirthday(DateTime birthday) => this._birthday = birthday;

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios,color: kPrimaryColor,),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserInfoScreen(),
                ));
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.urlImg),),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              // TextFieldWidget(
              //   label: 'About',
              //   text: user.about,
              //   maxLines: 5,
              //   onChanged: (about) {},
              // ),
              buildBirthday()
            ],
          ),
        ),
      );

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: _birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this._birthday = birthday),
        ),
      );

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 1,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
