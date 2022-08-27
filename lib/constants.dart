import 'package:flutter/material.dart';

const primaryColor=Color(0xFF43BEEE);
const accentColor=Color(0xFF010101);
const backgroundColor=Color(0xFFf0f0f0);
const textColor=Color(0xFFC7C7C7);
const buttonTextColor=Color(0xFFffffff);
const buttonColor=Colors.redAccent;

const containerColor=Colors.lightBlue;
const kTempTextStyle =
TextStyle(fontFamily: 'Spartan MB', fontSize: 100.0, color: Colors.white);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kInputTextDecoration = InputDecoration(
  filled: true,
  suffixIcon: Icon(Icons.search),
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


