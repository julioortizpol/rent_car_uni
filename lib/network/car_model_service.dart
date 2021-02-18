import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_source_pro/models/CarModel.dart';

Future<List<dynamic>> getCarModels() async {
  String url = 'http://localhost:4040/model/';
  Response response = await httpGetCarModels(url);
  if (response.statusCode == 200) {
    if (jsonDecode(response.body) != []) {
      List<CarModel> carModels = [];
      List carModelsJson = jsonDecode(response.body);
      carModelsJson.forEach((json) {
        carModels.add(CarModel.fromJson(json));
      });
      return carModels;
    } else {
      return jsonDecode(response.body);
    }
  } else {
    return [];
  }
}

Future<Response> httpGetCarModels(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateCarModel(CarModel carModel) async {
  String url = 'http://localhost:4040/model/${carModel.id}';
  Response response = await httpPatchCarModel(url, carModel);
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

Future<Response> httpPatchCarModel(String url, CarModel carModel) {
  return patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': carModel.description,
      'state': carModel.state,
      'brand': carModel.brand.id,
    }),
  );
}

Future createCarModel(CarModel carModel) async {
  String url = 'http://localhost:4040/model/';
  Response response = await httpPostCarModel(url, carModel);
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

Future<Response> httpPostCarModel(String url, CarModel carModel) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': carModel.description,
      'state': carModel.state,
      'brand': carModel.brand.id,
    }),
  );
}
