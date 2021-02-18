import 'dart:convert';

import 'package:http/http.dart';

import '../models/user.dart';

login(User user) async {
  String url = 'http://localhost:4040/user/';
  Response response = await httpPostUser(user, url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
    //return "User Loged";
  } else {
    return [];
    //_showMyDialog(jsonDecode(response.body)['message'], context);
    //return jsonDecode(response.body)['message'];
  }
}

Future<Response> httpPostUser(User user, String url) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'user': user.username,
      'password': user.password,
    }),
  );
}
