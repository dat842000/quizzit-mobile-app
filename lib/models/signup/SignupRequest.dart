import 'package:flutter_auth/models/Codable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SignupRequest.g.dart';
@JsonSerializable()
class SignupRequest implements Encodable{
  String username = "";
  String password = "";
  String fullName = "";
  String email = "";
  @JsonKey(toJson: formatDate)
  DateTime dateOfBirth = DateTime.now();

  SignupRequest.empty();

  SignupRequest(this.username, this.password, this.fullName, this.email,
      this.dateOfBirth);

  @override
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  static String formatDate(DateTime value)=>DateFormat(DateFormat.YEAR_MONTH_DAY).format(value);

}