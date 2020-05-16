import 'package:flutter/material.dart';

// HomePage Styling
// Day styling
const kCityDayStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black54);

const kTimeDayStyle =
    TextStyle(fontSize: 56, fontWeight: FontWeight.w600, color: Colors.black54);

// Night styling
const kCityNightStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white);
const kTimeNightStyle =
    TextStyle(fontSize: 56, fontWeight: FontWeight.w600, color: Colors.white);

// City Page Styling
const kCityTileStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(8)),
  boxShadow: [
    BoxShadow(
        color: Colors.grey,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        offset: Offset(2, 2))
  ],
);
