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
const GROUPS=[
  {
    "imgUrl":'https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/90954431_1582148621924471_7611655305281142784_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=825194&_nc_ohc=jgOg1-97daQAX--nxb2&_nc_ht=scontent-sin6-3.xx&oh=e405c37b9c016426c7052451ae7a161d&oe=60D913F0',
    "title":"Math Group",
    "decription":"Toan",
  },{
    "imgUrl":
    'https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.18169-9/28379844_10156181840423126_2758359348106619364_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=825194&_nc_ohc=P2ycqfZHNUUAX-pPnZK&_nc_ht=scontent.fsgn5-6.fna&oh=cafbc3bcc1801c35a918915e1ce4011f&oe=60DB12E0',
    "title": 'Physics Group',
    "description": 'Ly',
  },{
    "imgUrl":
    'https://image.shutterstock.com/image-vector/maths-hand-drawn-vector-illustration-260nw-460780561.jpg',
    "title": 'PRJ303_Survice',
    "description": 'Hoa',
  },{
    "imgUrl":
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREVI19c8BieX1brqjOdMKlt1mRINsKuLK6JA&usqp=CAU',
    "title": 'Math Group',
    "description": 'none',
  },{
    "imgUrl":
    'https://tr-images.condecdn.net/image/V2n9Jj303ye/crop/405/f/pamukkale-turkey-gettyimages-1223155251.jpg',
    "title": 'Math Group',
    "description": 'none',
  }
];

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