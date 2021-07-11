import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';
import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/subject/Subject.dart';
import 'package:quizzit/models/user/BaseUser.dart';
import 'package:quizzit/utils/ApiUtils.dart';

part 'GroupInfo.g.dart';

@JsonSerializable()
class GroupInfo extends Group implements Decodable {
  int totalPost;
  int totalSubjects;
  int totalQuestions;
  int totalQuizzesIn30Days;

  GroupInfo(
      int id,
      String name,
      String? image,
      int quizSize,
      bool isActive,
      DateTime createAt,
      int totalMem,
      List<Subject> subjects,
      BaseUser owner,
      int currentMemberStatus,
      this.totalPost,
      this.totalQuestions,
      this.totalQuizzesIn30Days,
      this.totalSubjects)
      : super(id, name, image, quizSize, isActive, createAt, totalMem, subjects,
            owner, currentMemberStatus);

  factory GroupInfo.fromJson(Map<String, dynamic> json) =>
      _$GroupInfoFromJson(json);
  static GroupInfo fromJsonModel(Map<String, dynamic> json) =>
      GroupInfo.fromJson(json);
}
