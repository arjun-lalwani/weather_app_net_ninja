import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/constants.dart';

class CityTile extends StatelessWidget {
  final String cityName;
  final String countryName;
  CityTile({@required this.cityName, @required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 10, right: 10),
      decoration: kCityTileStyle,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.ac_unit),
        ),
        title: Text(
          '$cityName',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        onTap: () {
          Navigator.pop(context, ['$cityName', '$countryName']);
        },
      ),
    );
  }
}
