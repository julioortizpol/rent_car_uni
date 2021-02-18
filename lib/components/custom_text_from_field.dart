import 'package:flutter/material.dart';

import '../utilities/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final Function getValue;
  final String hintText;
  final TextEditingController myController;

  const CustomTextFormField({this.getValue, this.hintText, this.myController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 300,
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value.isEmpty) {
            return "Campo vacio";
          } else {
            getValue(value);
          }

          return null;
        },
        //cursorColor: secondaryColor,
        decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      ),
    );
  }
}
