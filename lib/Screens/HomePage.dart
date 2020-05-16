import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/WorldTimes.dart';
import '../constants.dart';
import 'CityPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Time> time;
  WorldTimes worldTimeObj;

  @override
  void initState() {
    worldTimeObj = WorldTimes();
    time = worldTimeObj.getTimeIn(city: 'Los_Angeles');
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

  @override
  Widget build(BuildContext context) {
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
                        IconButton(
                          icon: Icon(
                            Icons.location_city,
                            size: 32,
                            color: (partOfDay == "day")
                                ? Colors.black54
                                : Colors.white,
                          ),
                          onPressed: () {
                            var x = worldTimeObj.getCitiesToCountries();
                            print(x);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CityPage(x)));
                          },
                        ),
                        CityTile(partOfDay: partOfDay),
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

class CityTile extends StatelessWidget {
  const CityTile({
    Key key,
    @required this.partOfDay,
  }) : super(key: key);

  final String partOfDay;

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
            "City Name",
            style: (partOfDay == "day") ? kCityDayStyle : kCityNightStyle,
          ),
        ],
      ),
    );
  }
}
