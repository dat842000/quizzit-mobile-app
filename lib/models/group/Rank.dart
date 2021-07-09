

import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/member/Member.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Rank.g.dart';

@JsonSerializable()
class Rank extends Member implements Decodable{
  int totalQuizzesIn30Days;
  int totalCorrectAnswersIn30Days;
  Rank(int id, String username, String fullName, String? avatar, String email, DateTime dateOfBirth, int status,  this.totalQuizzesIn30Days, this.totalCorrectAnswersIn30Days) : super(id, username, fullName, avatar, email, dateOfBirth, status);
  factory Rank.fromJson(Map<String, dynamic> json) =>
      _$RankFromJson(json);
  static Rank fromJsonModel(Map<String, dynamic> json) =>
      Rank.fromJson(json);
}