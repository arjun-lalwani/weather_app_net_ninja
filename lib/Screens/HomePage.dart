import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/models/WorldTimes.dart';
import '../components/CityInfo.dart';
import '../constants.dart';
import 'CityPage.dart';
import '../models/Time.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Time> time;
  WorldTimes worldTimeObj;
  String cityName = 'Los_Angeles';
  String countryName = 'America';

  @override
  void initState() {
    worldTimeObj = WorldTimes();
    super.initState();
  }

  String getBgImage(String partOfDay) {
    String bgImage = 'images';
    if (partOfDay == "evening") {
      return '$bgImage/evening_background.jpg';
    } else if (partOfDay == "night") {
      return '$bgImage/night_background.jpg';
    } else {
      return '$bgImage/day_background.jpg';
    }
  }

  _showCityPage() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityPage(this.worldTimeObj),
      ),
    );
    if (selectedLocation != false) {
      setState(() {
        cityName = selectedLocation[0];
        countryName = selectedLocation[1];
      });
    }
  }

  IconButton cityButton(String partOfDay) {
    return IconButton(
        icon: Icon(
          Icons.location_city,
          size: 32,
          color: (partOfDay == "day") ? Colors.black54 : Colors.white,
        ),
        onPressed: this._showCityPage);
  }

  @override
  Widget build(BuildContext context) {
    time = worldTimeObj.getTimeIn(city: '$cityName', country: '$countryName');

    return FutureBuilder(
      future: time,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Time time = snapshot.data;
          String partOfDay = time.partOfDay();
          String twelveHourClock = time.twelveHourClock();
          return Stack(
            children: [
              Image.asset(
                '${getBgImage(partOfDay)}',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 160),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        cityButton(partOfDay),
                        CityInfo(
                          partOfDay: partOfDay,
                          cityName: '$cityName',
                        ),
                        Text('$twelveHourClock',
                            style: (partOfDay == "day")
                                ? kTimeDayStyle
                                : kTimeNightStyle),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                value: null,
              ),
            ),
          );
        }
      },
    );
  }
}
