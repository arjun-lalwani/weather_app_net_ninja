import 'dart:convert';
import './Time.dart';
import 'package:http/http.dart' as http;

const url = 'http://worldtimeapi.org/api/timezone';

class WorldTimes {
  var _cityToCountry = {};

  WorldTimes() {
    _loadLocationInfo();
  }

  Future<Time> getTimeIn({String city, String country}) async {
    var response = await http.get('$url/$country/$city');
    if (response.statusCode == 200) {
      String dateTime = jsonDecode(response.body)['datetime'];
      return Time(dateTime);
    } else {
      throw Exception("Time Not Found");
    }
  }

  void _loadLocationInfo() async {
    var response = await http.get('$url');
    if (response.statusCode == 200) {
      List<dynamic> timeZoneJson = jsonDecode(response.body);

      // Response expected format: {Ameica/Chicago, America/Argentina/Buo_Aiers}
      // Parse response into city & country; ignore continent information
      timeZoneJson.forEach((e) {
        String location = e.toString();

        // Split location details into city & country
        if (location.indexOf('/') != -1) {
          var details = location.split('/');
          int countryIndex = (details.length == 2) ? 0 : 1;
          String country = details[countryIndex];
          String city = details[details.length - 1];

          // store city to country mapping
          _cityToCountry[city] = country;
        }
      });
    } else {
      throw Exception("Location Details Unavailable");
    }
  }

  Map<String, String> getCitiesToCountries() =>
      Map<String, String>.from(_cityToCountry);
}
