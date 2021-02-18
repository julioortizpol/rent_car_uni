class VehicleType {
  bool state;
  String description;
  String id;

  VehicleType({this.description, this.state, this.id});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
        description: json['desciption'],
        state: (json['state'] == null) ? true : json['state'],
        id: json['_id']);
  }

  @override
  String toString() {
    return 'VehicleType: {Brand: ${description}, State: ${state}, id: ${id}';
  }
}
