import 'CarBrand.dart';

class CarModel {
  String id;
  String description;
  bool state;
  CarBrand brand;

  CarModel({this.id, this.description, this.brand, this.state});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
        description: json['desciption'],
        state: (json['state'] == null) ? true : json['state'],
        id: json['_id'],
        brand: CarBrand.fromJson(json['brand']));
  }

  @override
  String toString() {
    return 'CarModel: {Model: ${description}, State: ${state}, id: ${id}} and CarBrand: {Model: ${brand.description}, State: ${brand.state}, id: ${brand.id}}';
  }
}
