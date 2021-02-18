import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_source_pro/models/RentAndReturn.dart';

Future<List<dynamic>> getRentsAndReturns() async {
  String url = 'http://localhost:4040/rentAndReturn/';
  http.Response response = await httpGetRentAndReturn(url);

  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<RentAndReturn> rentsAndReturns = [];
      List rentsAndReturnsJson = jsonDecode(response.body);

      rentsAndReturnsJson.forEach((json) {
        rentsAndReturns.add(RentAndReturn.fromJson(json));
      });

      return rentsAndReturns;
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

Future<http.Response> httpGetRentAndReturn(String url) {
  return http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateRentAndReturn(RentAndReturn rentAndReturn) async {
  String url = 'http://localhost:4040/rentAndReturn/${rentAndReturn.id}';
  http.Response response = await httpPatchRentAndReturn(url, rentAndReturn);
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

Future<http.Response> httpPatchRentAndReturn(
    String url, RentAndReturn rentAndReturn) {
  return http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'vehicle': rentAndReturn.vehicle,
      'state': rentAndReturn.state,
      'rentDate': jsonEncode(rentAndReturn.rentDate, toEncodable: myEncode),
      'devolutionDate':
          jsonEncode(rentAndReturn.devolutionDay, toEncodable: myEncode),
      'dayAmount': rentAndReturn.dayAmount,
      'comment': rentAndReturn.comment,
      'close': rentAndReturn.close,
      'client': rentAndReturn.client.id,
      'inspection': rentAndReturn.inspection,
      'employee': rentAndReturn.employee.id
    }),
  );
}

Future createRentAndReturn(RentAndReturn rentAndReturn) async {
  String url = 'http://localhost:4040/rentAndReturn/';
  http.Response response = await httpPostRentAndReturn(url, rentAndReturn);
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

Future<http.Response> httpPostRentAndReturn(
    String url, RentAndReturn rentAndReturn) {
  print(jsonEncode(rentAndReturn.devolutionDay, toEncodable: myEncode));
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'vehicle': rentAndReturn.vehicle,
      'state': rentAndReturn.state,
      'rentDate': jsonEncode(rentAndReturn.rentDate, toEncodable: myEncode),
      'devolutionDate':
          jsonEncode(rentAndReturn.devolutionDay, toEncodable: myEncode),
      'dayAmount': rentAndReturn.dayAmount,
      'comment': rentAndReturn.comment,
      'close': rentAndReturn.close,
      'client': rentAndReturn.client.id,
      'inspection': rentAndReturn.inspection,
      'employee': rentAndReturn.employee.id
    }),
  );
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
