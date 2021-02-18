import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  String dropDownValue;
  List<String> dropDownItems;
  Function getDropDownValue;
  CustomDropDown(
      {this.dropDownValue, this.dropDownItems, this.getDropDownValue});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropDownValue,
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.amberAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          widget.getDropDownValue(newValue);
          widget.dropDownValue = newValue;
        });
      },
      items: widget.dropDownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          key: Key("${value}"),
          value: value,
          child: Container(width: 250, child: Text(value)),
        );
      }).toList(),
    );
  }
}
