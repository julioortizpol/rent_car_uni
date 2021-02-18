import 'dart:core';

class Client {
  String personType;
  String personId;
  String id;
  String name;
  String creditLimit;
  bool state;
  String creditCard;

  Client(
      {this.creditLimit,
      this.personId,
      this.name,
      this.personType,
      this.state,
      this.id,
      this.creditCard});

  Client.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        personType = json['personType'],
        personId = json['personId'],
        id = json['_id'],
        creditLimit = json['creditLimit'],
        state = json['state'],
        creditCard = json['creditCard'];
}
