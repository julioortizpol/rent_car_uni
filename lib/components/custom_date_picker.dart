import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateFormPicker extends StatelessWidget {
  final DateFormat format;
  final String hintText;
  final Function action;
  final TextEditingController controller;
  CustomDateFormPicker(
      {this.format, this.hintText, this.action, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 10),
      child: DateTimeField(
        controller: controller,
        validator: (value) {
          if (value == null) {
            return "Campo Obligatorio";
          } else {
            action(value);
          }

          return null;
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
          ),
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
}
