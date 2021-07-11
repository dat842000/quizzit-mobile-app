import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'CreateGroupModel.g.dart';

@JsonSerializable()
class CreateGroupModel implements Encodable {
  String groupName;
  int quizSize;
  String? image;
  List<int> subjectIds;

  CreateGroupModel(this.groupName, this.quizSize, this.image, this.subjectIds);

  @override
  Map<String, dynamic> toJson() => _$CreateGroupModelToJson(this);
}
