import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF039BE5);
const kPrimaryLightColor = Color(0xFFE1F5FE);
const String defaultAvatar = "https://firebasestorage.googleapis.com/v0/b/groupsharingblogadminauth.appspot.com/o/default-avatar-1.png?alt=media&token=50dad4de-11a9-42ef-b53e-ad896fb9b524";
class Constants{
  static const all = 'All Group';
  static const own = 'Own Group';
  static const join =  'Join Group';
  static const suggest = 'Suggestion';
  static const choices = <String>[
    all,own,join,suggest
  ];
  static const adminManageUser = <String>[
    'Members','New Requests'
  ];
  static const postSetting= <String>[
    'Edit','Delete'
  ];
}
enum HttpMethod { GET, POST, PUT, DELETE }

abstract class MemberStatus{
  static const int notInGroup = 0;
  static const int pending=1;
  static const int member=2;
  static const int owner=3;
  static const int kicked = 4;
  static const int banned = 5;
  static const int leave = 6;
  static const List<int> inGroupStatuses=[member,owner];
  // static const int
}

enum MemberStatusConst{
  NotInGroup,Pending,Member,Owner,Kicked,Banned,Leave
}

class Host {
  static const String name = "hieulnhcm.ddns.net";
  // static const String name = "localhost";
  static const int port = 5001;
  static const String _root = "/api";
  static const String login = "$_root/login";
  static const String subjects = "$_root/subjects";
  static const String users = "$_root/users";
  static const String groups = "$_root/groups";
  static String groupPost({required int groupId})=>"$groups/$groupId/posts";
  static const String posts = "$_root/posts";
  static String postComment(int postId)=>"$posts/$postId/comments";
  static const String members = "$_root/members";
  static const String questions = "$_root/questions";
  static String groupOwnerQuestion({required int groupId})=>"$groups/$groupId/questions";
  static String groupOwnerUpdateAddQuestion({required int groupId, required int questionId})=>"$groups/$groupId/questions/$questionId";
}