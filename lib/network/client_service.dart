import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Client.dart';

getClient(String id) async {
  String url = 'http://localhost:4040/client/$id';
  http.Response response = await httpGetClient(url);
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

Future<List<dynamic>> getClients() async {
  String url = 'http://localhost:4040/client/';
  http.Response response = await httpGetClient(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<Client> clients = [];
      List clientJson = jsonDecode(response.body);
      clientJson.forEach((json) {
        clients.add(Client.fromJson(json));
      });
      return clients;
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

Future<http.Response> httpGetClient(String url) {
  return http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateClient(Client client) async {
  String url = 'http://localhost:4040/client/${client.id}';
  http.Response response = await httpPatchCarModel(url, client);
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

Future<http.Response> httpPatchCarModel(String url, Client client) {
  return http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'personId': client.personId,
      'state': client.state,
      'name': client.name,
      'creditCard': client.creditCard,
      'personType': client.personType,
      'creditLimit': client.creditLimit
    }),
  );
}

Future createClient(Client client) async {
  String url = 'http://localhost:4040/client/';
  http.Response response = await httpPostClient(url, client);
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

Future<http.Response> httpPostClient(String url, Client client) {
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'personId': client.personId,
      'state': client.state,
      'name': client.name,
      'creditCard': client.creditCard,
      'personType': client.personType,
      'creditLimit': client.creditLimit
    }),
  );
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
