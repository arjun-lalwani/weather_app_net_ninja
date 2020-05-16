import 'package:flutter/material.dart';
import 'package:weather_app_net_ninja/screens/HomePage.dart';
import './Screens/CityPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/city': (context) => CityPage({}),
      },
    );
  }
}