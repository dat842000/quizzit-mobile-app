import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/constants.dart';

Future<http.Response> fetch(String endpoint, HttpMethod method,
    Map<String, dynamic>? data, Map<String, String>? params) {
  if (endpoint == null) throw new ArgumentError("Invalid Url");
  var uri = Uri.https("${Host.name}:${Host.port}", "$endpoint", params);
  var headers = {
    HttpHeaders.authorizationHeader: "",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptEncodingHeader: "application/json"
  };
  var body = json.encode(data);
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
extension StatusMatcher on int{
  bool isOk() => this>=200&&this<=299;
}
