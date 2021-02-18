import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_source_pro/models/FuelType.dart';

Future<List<dynamic>> getFuelType() async {
  String url = 'http://localhost:4040/fuel/';
  Response response = await httpGetFuelTypes(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<FuelType> fuelTypes = [];
      List fuelTypesJson = jsonDecode(response.body);
      fuelTypesJson.forEach((json) {
        fuelTypes.add(FuelType.fromJson(json));
      });
      return fuelTypes;
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

Future<Response> httpGetFuelTypes(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateFuelType(FuelType fuelType) async {
  String url = 'http://localhost:4040/fuel/${fuelType.id}';
  Response response = await httpPatchFuelTypes(url, fuelType);
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

Future<Response> httpPatchFuelTypes(String url, FuelType fuelType) {
  return patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': fuelType.description,
      'state': fuelType.state
    }),
  );
}

Future createFuelTypes(FuelType fuelType) async {
  String url = 'http://localhost:4040/fuel/';
  Response response = await httpPostFuelTypes(url, fuelType);
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

Future<Response> httpPostFuelTypes(String url, FuelType fuelType) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': fuelType.description,
      'state': fuelType.state
    }),
  );
}
