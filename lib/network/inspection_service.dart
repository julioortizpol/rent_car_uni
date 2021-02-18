import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_source_pro/models/Inspection.dart';

getInspection(String id) async {
  String url = 'http://localhost:4040/inspection/$id';
  Response response = await httpGetInspection(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      return Inspection.fromJson(jsonDecode(response.body));
    } else {
      return Inspection.fromJson(jsonDecode(response.body));
    }
    //return "User Loged";
  } else {
    return [];
    //_showMyDialog(jsonDecode(response.body)['message'], context);
    //return jsonDecode(response.body)['message'];
  }
}

Future<Response> httpGetInspection(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future createInspection(Inspection inspection) async {
  String url = 'http://localhost:4040/inspection/';
  Response response = await httpPostInspection(url, inspection);
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

Future<Response> httpPostInspection(String url, Inspection inspection) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'vehicle': inspection.vehicle,
      'wheelState': inspection.wheelState,
      'grated': inspection.grated,
      'fuelQuantity': inspection.fuelQuantity,
      'state': inspection.state,
      'replacementRubber': inspection.replacementRubber,
      'vehicleJack': inspection.vehicleJack,
      'breakingGlass': inspection.breakingGlass,
      'employeeId': inspection.employee,
      'date': jsonEncode(inspection.date, toEncodable: myEncode),
    }),
  );
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
