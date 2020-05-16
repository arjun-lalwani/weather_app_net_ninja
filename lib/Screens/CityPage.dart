import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/constants.dart';

class CityPage extends StatefulWidget {
  final Map<String, String> cityToCountries;

  CityPage(this.cityToCountries);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  var cities;

  @override
  void initState() {
    cities = widget.cityToCountries.keys.toList();
    cities.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEDEF),
      appBar: AppBar(
        title: Text('Choose Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return CityTile(cityName: city);
        },
      ),
    );
  }
}

class CityTile extends StatelessWidget {
  final String cityName;
  CityTile({@required this.cityName});

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
        onTap: () {},
      ),
    );
  }
}
