import 'dart:convert';

import 'package:http/http.dart';

import '../models/Employee.dart';

getEmployee(String id) async {
  String url = 'http://localhost:4040/employee/$id';
  Response response = await httpGetEmployee(url);
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

Future<List<dynamic>> getEmployees() async {
  String url = 'http://localhost:4040/employee/';
  Response response = await httpGetEmployee(url);
  if (response.statusCode == 200) {
    //addStringToSF('accessToken', jsonDecode(response.body)['accessToken']);
    if (jsonDecode(response.body) != []) {
      List<Employee> employee = [];
      List employeesJson = jsonDecode(response.body);
      employeesJson.forEach((json) {
        employee.add(Employee.fromJson(json));
      });
      return employee;
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

Future<Response> httpGetEmployee(String url) {
  return get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
}

Future updateEmployee(Employee employee) async {
  String url = 'http://localhost:4040/employee/${employee.id}';
  Response response = await httpPatchCarModel(url, employee);
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

Future<Response> httpPatchCarModel(String url, Employee employee) {
  return patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'personId': employee.personId,
      'state': employee.state,
      'name': employee.name,
      'workShift': employee.workShift,
      'comisionPercent': employee.commissionPercent,
      'dateOfAdmision':
          jsonEncode(employee.dateOfAdmission, toEncodable: myEncode),
    }),
  );
}

Future createEmployee(Employee employee) async {
  String url = 'http://localhost:4040/employee/';
  Response response = await httpPostCarModel(url, employee);
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

Future<Response> httpPostCarModel(String url, Employee employee) {
  return post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'personId': employee.personId,
      'state': employee.state,
      'name': employee.name,
      'workShift': employee.workShift,
      'comisionPercent': employee.commissionPercent,
      'dateOfAdmision':
          jsonEncode(employee.dateOfAdmission, toEncodable: myEncode),
    }),
  );
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
