import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/constants.dart';
// import 'package:flutter_auth/models/problemdetails/ProblemDetails.dart';

void main() async {
  // await Firebase.initializeApp();
  // var response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "haseoleonard@gmail.com",
  //     password: "14021998");
  // print(response.additionalUserInfo?.username);
  // var data = new LoginRequest();
  // var body = new Map<String, String>();
  // body.putIfAbsent("username", () => "Admin");
  // body.putIfAbsent("password", () => "Admin");
  // var response = await fetch(Host.users, HttpMethod.GET, null, null);
  // if (response.statusCode >= 200 && response.statusCode <= 299)
  //   print(response.body);
  // else{
  //   var problem = ProblemDetails.fromJson(jsonDecode(response.body));
  //   print(problem.message);
  //   if(problem.errors!=null)
  //     print(problem.errors);
  //   else if(problem.params!=null)
  //     print(problem.params);
  // }
}

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
