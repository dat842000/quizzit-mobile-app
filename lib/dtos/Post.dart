import 'User.dart';

class Post{
  final String title;
  final String content;
  final DateTime createdDate;
  final String urlImg;
  final User user;
  Post(this.title,this.createdDate,this.urlImg,this.content,this.user);
}