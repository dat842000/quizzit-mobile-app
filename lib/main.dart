import 'dart:developer';
import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
      headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
      springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent:0, // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
      child: MaterialApp(
      )
  );
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
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
