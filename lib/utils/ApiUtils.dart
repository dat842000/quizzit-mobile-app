import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:quizzit/constants.dart';
import 'package:quizzit/models/Codable.dart';

Future<http.Response> fetch(String endpoint, HttpMethod method,
    {Encodable? data, Map<String, String>? params}) async {
  if (endpoint == null) throw new ArgumentError("Invalid Url");
  var uri = Uri.https("${Host.name}:${Host.port}", endpoint, params);
  String token = "";
  if (FirebaseAuth.instance != null &&
      FirebaseAuth.instance.currentUser != null)
    token = "Bearer ${await FirebaseAuth.instance.currentUser!.getIdToken()}";
  var headers = {
    HttpHeaders.authorizationHeader: token,
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptEncodingHeader: "application/json"
  };
  var body = json.encode(data?.toJson());
  switch (method) {
    case HttpMethod.GET:
      return http.get(uri, headers: headers);
    case HttpMethod.POST:
      return http.post(uri, headers: headers, body: body);
    case HttpMethod.PUT:
      return http.put(uri, headers: headers, body: body);
    case HttpMethod.DELETE:
      return http.delete(uri, headers: headers, body: body);
  }
}

extension StatusMatcher on int {
  bool isOk() => this >= 200 && this <= 299;
}

DateTime fromJsonUTC(String jsonDate) {
  DateTime value = DateTime.parse(jsonDate);
  return DateTime.utc(value.year, value.month, value.day, value.hour,
          value.minute, value.second, value.millisecond, value.microsecond)
      .toLocal();
}
