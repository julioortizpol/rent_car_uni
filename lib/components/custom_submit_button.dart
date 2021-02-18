import 'package:flutter/material.dart';

import '../utilities/styles.dart';

class CustomSubmitButton extends StatelessWidget {
  final String buttonText;
  final Function buttonAction;
  final formKey;
  CustomSubmitButton({this.buttonText, this.buttonAction, this.formKey});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.amber,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      onPressed: () {
        buttonAction();
      },
      child: Container(
        width: 300,
        child: Center(
          child: Text(
            buttonText,
            style: buttonStyle,
          ),
        ),
      ),
    );
  }
}
