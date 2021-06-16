import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditUserProfile/components/body.dart';
import 'package:flutter_auth/models/user/UserInfo.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen(this._user);
  final UserInfo _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(this._user),
    );
  }
}