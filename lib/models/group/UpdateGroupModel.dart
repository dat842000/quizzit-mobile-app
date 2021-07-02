import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UpdateGroupModel.g.dart';

@JsonSerializable()
class UpdateGroupModel implements Encodable{
  String groupName;
  int quizSize;
  String? image;
  List<int> subjectIds;

  UpdateGroupModel(this.groupName, this.quizSize , this.image, this.subjectIds);

  @override
  Map<String, dynamic> toJson() => _$UpdateGroupModelToJson(this);

}