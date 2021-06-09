import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF039BE5);
const kPrimaryLightColor = Color(0xFFE1F5FE);

class Constants{
  static const own = 'Own Group';
  static const join =  'Join Group';
  static const suggest = 'Suggestion';
  static const choices = <String>[
    own,join,suggest
  ];
}
enum HttpMethod { GET, POST, PUT, DELETE }

class Host {
  static const String name = "hieulnhcm.ddns.net";
  static const int port = 5001;
  static const String _root = "/api";
  static const String login = "$_root/login";
  static const String subjects = "$_root/subjects";
  static const String users = "$_root/users";
  static const String groups = "$_root/groups";
  static const String members = "$_root/members";
  static const String questions = "$_root/questions";
}