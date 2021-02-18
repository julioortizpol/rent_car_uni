class CarBrand {
  bool state;
  String description;
  String id;

  CarBrand({this.description, this.state, this.id});

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
        description: json['desciption'],
        state: (json['state'] == null) ? true : json['state'],
        id: json['_id']);
  }

  @override
  String toString() {
    return 'CarBrand: {Brand: ${description}, State: ${state}, id: ${id}';
  }
}
