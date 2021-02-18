import 'dart:core';

import 'package:open_source_pro/models/CarBrand.dart';
import 'package:open_source_pro/models/CarModel.dart';
import 'package:open_source_pro/models/FuelType.dart';
import 'package:open_source_pro/models/VehicleType.dart';

class Vehicle {
  String description;
  String chasisNumber;
  String id;
  String motorNumber;
  String licensePlateNumber;
  VehicleType vehicleType;
  FuelType fuelType;
  CarModel carModel;
  CarBrand carBrand;
  bool state;
  String photo;

  Vehicle(
      {this.licensePlateNumber,
      this.motorNumber,
      this.chasisNumber,
      this.description,
      this.id,
      this.state,
      this.carBrand,
      this.fuelType,
      this.carModel,
      this.vehicleType,
      this.photo});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    json['model']['brand'] = json['brand'];
    return Vehicle(
        description: json['desciption'],
        chasisNumber: json['chasisNumber'],
        motorNumber: json['motorNumber'],
        id: json['_id'],
        licensePlateNumber: json['licensePlateNumber'],
        vehicleType: VehicleType.fromJson(json['vehicleType']),
        state: json['state'],
        fuelType: FuelType.fromJson(json['fuelType']),
        carModel: CarModel.fromJson(json['model']),
        carBrand: CarBrand.fromJson(json['brand']),
        photo: json['imageUrl']);
  }
}
