import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_source_pro/models/CarBrand.dart';

Future<List<dynamic>> getCarBrands() async {
  String url = 'http://localhost:4040/brand/';
  Response response = await httpGetCarBrands(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<CarBrand> carBrands = [];
      List carBrandsJson = jsonDecode(response.body);
      carBrandsJson.forEach((json) {
        carBrands.add(CarBrand.fromJson(json));
      });
      return carBrands;
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

Future updateCarBrands(CarBrand carBrand) async {
  String url = 'http://localhost:4040/brand/${carBrand.id}';
  Response response = await httpPatchCarBrands(url, carBrand);
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

Future createCarBrands(CarBrand carBrand) async {
  String url = 'http://localhost:4040/brand/';
  Response response = await httpPostCarBrands(url, carBrand);
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

Future<Response> httpGetCarBrands(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future<Response> httpPatchCarBrands(String url, CarBrand carBrand) {
  return patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': carBrand.description,
      'state': carBrand.state
    }),
  );
}

Future<Response> httpPostCarBrands(String url, CarBrand carBrand) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'desciption': carBrand.description,
      'state': carBrand.state
    }),
  );
}
