import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}