import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) {
        final isValidHost = [Host.name]
            .contains(host); // <-- allow only hosts in array
        return isValidHost;
      });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.reload().then((value) =>
          FirebaseAuth.instance.currentUser!.getIdToken().then((value) =>
              log(value)));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizit',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen()
          : DashboardScreen(),
    );
  }
}
