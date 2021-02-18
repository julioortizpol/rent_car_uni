class Inspection {
  String id;
  List<dynamic> wheelState;
  String vehicle;
  bool grated;
  String fuelQuantity;
  bool replacementRubber;
  bool vehicleJack;
  bool breakingGlass;
  DateTime date;
  String employee;
  bool state;

  Inspection(
      {this.vehicle,
      this.id,
      this.state,
      this.employee,
      this.breakingGlass,
      this.date,
      this.fuelQuantity,
      this.grated,
      this.replacementRubber,
      this.vehicleJack,
      this.wheelState});

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
        wheelState: json['wheelState'],
        vehicle: json['vehicle'],
        id: json['_id'],
        grated: json['grated'],
        fuelQuantity: json['fuelQuantity'],
        state: json['state'],
        replacementRubber: json['replacementRubber'],
        vehicleJack: json['vehicleJack'],
        breakingGlass: json['breakingGlass'],
        date: DateTime.parse(json['date']),
        employee: (json['employeeId']));
  }
}
