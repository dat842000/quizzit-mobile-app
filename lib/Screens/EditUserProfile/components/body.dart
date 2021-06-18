import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditUserProfile/components/birthday_edit_widget.dart';
import 'package:flutter_auth/Screens/UserInfo/user_info.dart';
import 'package:flutter_auth/components/rounded_image.dart';
import 'package:flutter_auth/components/textfield_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:flutter_auth/models/user/UserInfo.dart';

class Body extends StatefulWidget {
  const Body(this._user);

  final UserInfo _user;

  @override
  _BodyState createState() => _BodyState(_user);
}

class _BodyState extends State<Body> {
  _BodyState(this._user);
  final UserInfo _user;

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              ),
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
                backgroundImage: NetworkImage(this._user.avatar??defaultAvatar),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: this._user.fullName,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: this._user.email,
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
          birthday: this._user.dateOfBirth,
          onChangedBirthday: (birthday) =>
              setState(() => this._user.dateOfBirth = birthday),
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
