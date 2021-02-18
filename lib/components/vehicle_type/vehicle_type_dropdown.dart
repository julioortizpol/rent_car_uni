import 'package:flutter/material.dart';
import 'package:open_source_pro/models/VehicleType.dart';

import '../custom_drop_down.dart';

class VehicleTypeDropdown extends StatelessWidget {
  List<VehicleType> vehicleType;
  String actualVehicleType;
  Function getDropDownValue;
  VehicleTypeDropdown(
      {this.vehicleType, this.actualVehicleType, this.getDropDownValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Tipo de Vehiculo: "),
        SizedBox(
          width: 10,
        ),
        Container(
          child: CustomDropDown(
            dropDownItems: vehicleType.map((e) => e.description).toList(),
            dropDownValue: actualVehicleType,
            getDropDownValue: (value) {
              if (!(actualVehicleType == value)) {
                actualVehicleType = value;
                List vehicleTypeFilter = vehicleType
                    .where((element) => element.description == value)
                    .toList();
                VehicleType vehicleTypeObject = vehicleTypeFilter[0];
                return getDropDownValue(vehicleTypeObject);
              }
            },
          ),
        ),
      ],
    );
  }
}
