import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Vehicle.dart';

getVehicle(String id) async {
  String url = 'http://localhost:4040/vehicle/$id';
  http.Response response = await httpGetVehicle(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      return Vehicle.fromJson(jsonDecode(response.body));
    } else {
      return Vehicle.fromJson(jsonDecode(response.body));
    }
    //return "User Loged";
  } else {
    return [];
    //_showMyDialog(jsonDecode(response.body)['message'], context);
    //return jsonDecode(response.body)['message'];
  }
}

Future<List<dynamic>> getVehicles() async {
  String url = 'http://localhost:4040/vehicle/';
  http.Response response = await httpGetVehicle(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<Vehicle> vehicles = [];
      List vehicleJson = jsonDecode(response.body);
      vehicleJson.forEach((json) {
        vehicles.add(Vehicle.fromJson(json));
      });
      return vehicles;
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

Future<http.Response> httpGetVehicle(String url) {
  return http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateVehicle(Vehicle vehicle) async {
  String url = 'http://localhost:4040/vehicle/${vehicle.id}';
  http.Response response = await httpPatchVehicle(url, vehicle);
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

Future<http.Response> httpPatchVehicle(String url, Vehicle vehicle) {
  return http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': vehicle.description,
      'state': vehicle.state,
      'chasisNumber': vehicle.chasisNumber,
      'motorNumber': vehicle.motorNumber,
      'licensePlateNumber': vehicle.licensePlateNumber,
      'vehicleType': vehicle.vehicleType.id,
      'fuelType': vehicle.fuelType.id,
      'model': vehicle.carModel.id,
      'brand': vehicle.carBrand.id,
      'imageUrl': vehicle.photo
    }),
  );
}

Future createVehicle(Vehicle vehicle) async {
  String url = 'http://localhost:4040/vehicle/';
  http.Response response = await httpPostVehicle(url, vehicle);
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

Future<http.Response> httpPostVehicle(String url, Vehicle vehicle) {
  print(vehicle);
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': vehicle.description,
      'state': vehicle.state,
      'chasisNumber': vehicle.chasisNumber,
      'motorNumber': vehicle.motorNumber,
      'licensePlateNumber': vehicle.licensePlateNumber,
      'vehicleType': vehicle.vehicleType.id,
      'fuelType': vehicle.fuelType.id,
      'model': vehicle.carModel.id,
      'brand': vehicle.carBrand.id,
      'imageUrl': vehicle.photo
    }),
  );
}
