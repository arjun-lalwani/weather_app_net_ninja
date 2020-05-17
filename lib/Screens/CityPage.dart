import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/models/WorldTimes.dart';
import '../components/CityTile.dart';

class CityPage extends StatefulWidget {
  final WorldTimes worldTimeObj;
  CityPage(this.worldTimeObj);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  var cityToCountry = {};
  List<String> cities = [];

  @override
  void initState() {
    cityToCountry = widget.worldTimeObj.getCitiesToCountries();
    cities = cityToCountry.keys.toList();
    cities.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEDEF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Choose Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return CityTile(cityName: city, countryName: cityToCountry[city]);
        },
      ),
    );
  }
}
