import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = 'http://worldtimeapi.org/api/timezone';

class WorldTimes {
  var _cityToCountry = {};

  WorldTimes() {
    _loadCities();
  }

  Future<Time> getTimeIn({String city}) async {
    var response = await http.get('$url/America/$city');
    if (response.statusCode == 200) {
      String dateTime = jsonDecode(response.body)['datetime'];
      return Time(dateTime: dateTime);
    } else {
      throw Exception("Time Not Found");
    }
  }

  void _loadCities() async {
    var response = await http.get('$url');
    if (response.statusCode == 200) {
      List<dynamic> timeZoneJson = jsonDecode(response.body);
      timeZoneJson.forEach((e) {
        String timeZone = e.toString();
        if (timeZone.indexOf('/') != -1) {
          String country = timeZone.substring(0, timeZone.indexOf('/'));
          String city =
              timeZone.substring(timeZone.indexOf('/') + 1, timeZone.length);
          _cityToCountry[city] = country;
        }
      });
    }
  }

  Map<String, String> getCitiesToCountries() {
    var x = Map<String, String>.from(_cityToCountry);

    return x;
  }
}

class Time {
  int _hours;
  int _minutes;
  bool _isDay;
  String dateTime;

  Time({@required this.dateTime}) {
    String time = dateTime.substring(
        dateTime.indexOf('T') + 1, dateTime.indexOf('.') - 3);
    this._hours = int.parse(time.substring(0, time.indexOf(':')));
    this._minutes =
        int.parse(time.substring(time.indexOf(':') + 1, time.length));
    this._isDay = (this._hours > 12) ? true : false;
  }

  String twelveHourClock() {
    return (_hours > 12)
        ? "${_hours - 12}:$_minutes PM"
        : "$_hours:$_minutes AM";
  }

  String partOfDay() {
    if (_hours > 16 && _hours < 20) {
      return "evening";
    } else if (_hours >= 20 || _hours <= 8) {
      return "night";
    } else {
      return "day";
    }
  }

  bool isDay() => this._isDay;
}
