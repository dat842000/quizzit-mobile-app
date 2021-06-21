import 'dart:io';

import 'User.dart';

class Post{
  final String title;
  final String content;
  final String plainText;
  final DateTime createdDate;
  final File? urlImg;
  final User user;
  Post(this.title,this.createdDate,this.urlImg,this.content,this.user,this.plainText);
}
