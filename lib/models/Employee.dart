import 'dart:core';

class Employee {
  String workShift;
  String personId;
  String id;
  String name;
  DateTime dateOfAdmission;
  String commissionPercent;
  bool state;

  Employee(
      {this.commissionPercent,
      this.personId,
      this.name,
      this.dateOfAdmission,
      this.workShift,
      this.state,
      this.id});

  Employee.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        workShift = json['workShift'],
        personId = json['personId'],
        dateOfAdmission = DateTime.parse(
          json['dateOfAdmision'],
        ),
        id = json['_id'],
        commissionPercent = json['comisionPercent'],
        state = json['state'];
}
