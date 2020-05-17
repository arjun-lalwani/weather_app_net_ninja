import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/constants.dart';

class CityInfo extends StatelessWidget {
  const CityInfo({
    Key key,
    @required this.partOfDay,
    @required this.cityName,
  }) : super(key: key);

  final String partOfDay;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag,
            size: 42,
            color: (partOfDay == "day") ? Colors.black54 : Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "$cityName",
            style: (partOfDay == "day") ? kCityDayStyle : kCityNightStyle,
          ),
        ],
      ),
    );
  }
}
