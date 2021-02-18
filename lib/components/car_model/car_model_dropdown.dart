import 'package:flutter/material.dart';
import 'package:open_source_pro/models/CarModel.dart';

import '../custom_drop_down.dart';

class CarModelDropdown extends StatefulWidget {
  List<CarModel> carModel;
  String actualCarModel;
  Function getDropDownValue;
  CarModelDropdown({this.carModel, this.actualCarModel, this.getDropDownValue});

  @override
  _CarModelDropdownState createState() => _CarModelDropdownState();
}

class _CarModelDropdownState extends State<CarModelDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Modelo Carro: "),
        SizedBox(
          width: 10,
        ),
        Container(
          child: CustomDropDown(
            dropDownItems: widget.carModel
                .map((e) => "${e.description} - ${e.brand.description}")
                .toList(),
            dropDownValue: widget.actualCarModel,
            getDropDownValue: (value) {
              if (!(widget.actualCarModel == value)) {
                widget.actualCarModel = value;
                List carModelFilter = widget.carModel
                    .where((element) =>
                        "${element.description} - ${element.brand.description}" ==
                        value)
                    .toList();
                CarModel carModelObject = carModelFilter[0];
                return widget.getDropDownValue(carModelObject);
              }
            },
          ),
        ),
      ],
    );
  }
}
