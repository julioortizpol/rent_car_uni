import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
  ),
);
const buttonStyle = TextStyle(fontSize: 20, color: Colors.white);
