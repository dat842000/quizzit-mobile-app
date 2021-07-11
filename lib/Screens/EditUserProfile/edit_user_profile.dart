import 'package:flutter/material.dart';
import 'package:quizzit/Screens/EditUserProfile/components/body.dart';
import 'package:quizzit/models/user/BaseUser.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen(this._user);
  final BaseUser _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(this._user),
    );
  }
}
