import 'dart:html';

import 'package:open_source_pro/models/Employee.dart';

import './Client.dart';

class RentAndReturn {
  String id;
  String vehicle;
  DateTime rentDate;
  DateTime devolutionDay;
  int dayAmount;
  Client client;
  String comment;
  bool close;
  Employee employee;
  bool state;
  String inspection;

  RentAndReturn(
      {this.vehicle,
      this.id,
      this.state,
      this.employee,
      this.close,
      this.devolutionDay,
      this.rentDate,
      this.dayAmount,
      this.comment,
      this.client,
      this.inspection});

  factory RentAndReturn.fromJson(Map<String, dynamic> json) {
    return RentAndReturn(
        vehicle: json['vehicle'],
        id: json['_id'],
        rentDate: DateTime.parse(
          json['rentDate'],
        ),
        devolutionDay: DateTime.parse(
          json['devolutionDate'],
        ),
        state: json['state'],
        dayAmount: json['dayAmount'],
        comment: json['comment'],
        close: json['close'],
        client: Client.fromJson(json['client']),
        inspection: json['inspection'],
        employee: Employee.fromJson(json['employee']));
  }
}
