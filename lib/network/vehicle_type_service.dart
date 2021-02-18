import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_source_pro/models/VehicleType.dart';

Future<List<dynamic>> getVehicleType() async {
  String url = 'http://localhost:4040/vehicleType/';
  Response response = await httpGetVehicleType(url);
  if (response.statusCode == 200) {
    if (jsonDecode(response.body) != []) {
      List<VehicleType> vehicleType = [];
      List vehicleTypeJson = jsonDecode(response.body);
      vehicleTypeJson.forEach((json) {
        vehicleType.add(VehicleType.fromJson(json));
      });
      return vehicleType;
    } else {
      return jsonDecode(response.body);
    }
  } else {
    return [];
  }
}

Future<Response> httpGetVehicleType(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateVehicleType(VehicleType vehicleType) async {
  String url = 'http://localhost:4040/vehicleType/${vehicleType.id}';
  Response response = await httpPatchVehicleType(url, vehicleType);
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

Future<Response> httpPatchVehicleType(String url, VehicleType vehicleType) {
  return patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': vehicleType.description,
      'state': vehicleType.state
    }),
  );
}

Future createVehicleType(VehicleType vehicleType) async {
  String url = 'http://localhost:4040/vehicleType/';
  Response response = await httpPostVehicleType(url, vehicleType);
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

Future<Response> httpPostVehicleType(String url, VehicleType vehicleType) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': vehicleType.description,
      'state': vehicleType.state
    }),
  );
}
