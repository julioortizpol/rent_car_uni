import 'package:flutter/material.dart';
import 'package:open_source_pro/models/CarBrand.dart';

import '../custom_drop_down.dart';

class CarBrandDropDown extends StatefulWidget {
  List<CarBrand> carsBrands;
  String actualBrand;
  Function getDropDownValue;
  CarBrandDropDown({this.carsBrands, this.actualBrand, this.getDropDownValue});

  @override
  _CarBrandDropDownState createState() => _CarBrandDropDownState();
}

class _CarBrandDropDownState extends State<CarBrandDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Marca: "),
        SizedBox(
          width: 10,
        ),
        Container(
          child: CustomDropDown(
            dropDownItems: widget.carsBrands.map((e) => e.description).toList(),
            dropDownValue: widget.actualBrand,
            getDropDownValue: (value) {
              print(widget.actualBrand);
              if (!(widget.actualBrand == value)) {
                widget.actualBrand = value;
                List carBrandFilter = widget.carsBrands
                    .where((element) => element.description == value)
                    .toList();
                CarBrand carBrandObject = carBrandFilter[0];
                return widget.getDropDownValue(carBrandObject);
              }
            },
          ),
        ),
      ],
    );
  }
}
