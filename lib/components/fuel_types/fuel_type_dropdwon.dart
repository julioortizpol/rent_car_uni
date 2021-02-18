import 'package:flutter/material.dart';
import 'package:open_source_pro/models/FuelType.dart';

import '../custom_drop_down.dart';

class FuelTypeDropDown extends StatelessWidget {
  List<FuelType> fuelType;
  String actualfuelType;
  Function getDropDownValue;
  FuelTypeDropDown({this.fuelType, this.actualfuelType, this.getDropDownValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Combustible: "),
        SizedBox(
          width: 10,
        ),
        Container(
          child: CustomDropDown(
            dropDownItems: fuelType.map((e) => e.description).toList(),
            dropDownValue: actualfuelType,
            getDropDownValue: (value) {
              print(actualfuelType);
              if (!(actualfuelType == value)) {
                actualfuelType = value;
                List fuelTypeFilter = fuelType
                    .where((element) => element.description == value)
                    .toList();
                FuelType fuelTypeObject = fuelTypeFilter[0];
                return getDropDownValue(fuelTypeObject);
              }
            },
          ),
        ),
      ],
    );
  }
}
