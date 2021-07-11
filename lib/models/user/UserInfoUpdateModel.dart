import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'UserInfoUpdateModel.g.dart';

@JsonSerializable()
class UserInfoUpdateModel implements Encodable {
  String email;
  String fullName;
  @JsonKey(toJson: convertDate)
  DateTime dateOfBirth;

  UserInfoUpdateModel(this.email, this.fullName, this.dateOfBirth);

  @override
  Map<String, dynamic> toJson() => _$UserInfoUpdateModelToJson(this);
  static String convertDate(DateTime dateTime) =>
      DateFormat(DateFormat.YEAR_MONTH_DAY).format(dateTime);
}
