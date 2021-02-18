class FuelType {
  bool state;
  String description;
  String id;

  FuelType({this.description, this.state, this.id});

  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(
        description: json['desciption'],
        state: (json['state'] == null) ? true : json['state'],
        id: json['_id']);
  }

  @override
  String toString() {
    return 'CarBrand: {Brand: ${description}, State: ${state}, id: ${id}';
  }
}
