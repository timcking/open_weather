import 'package:flutter/material.dart';

ButtonStyle kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.indigo),
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 60.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 50.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Roboto',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
