import 'dart:math';

import 'package:animation_test/widgets/all_weathers.dart';
import 'package:flutter/material.dart';

class SingleWeatherPage extends StatelessWidget {

  final String name;
  final int index;


  SingleWeatherPage(this.name, this.index);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = min(size.width, size.height) / 5 * 4;

    final List<Widget> weathers = [
      WeatherCloudy(
        height: width,
        width: width,
        showBorder: true,
      ),
      WeatherSunny(
        sunnySize: width,
        sunColor: Colors.deepOrange,
        showBorder: true,
      ),
      WeatherDropping(
        droppingHeight: width,
        droppingWidth: width,
        droppingColor: Colors.lightBlueAccent,
        droppingLevel: DroppingLevel.medium,
        showBorder: true,
      ),
      WeatherDropping(
        borderDecoration: BoxDecoration(color: Colors.black),
        droppingHeight: width,
        droppingWidth: width,
        droppingColor: Colors.white,
        droppingLevel: DroppingLevel.medium,
        droppingType: DroppingType.snow,
        showBorder: true,
      ),
      WeatherDropWithCloud(
        showBorder: true,
        size: width,
      ),
      WeatherDropWithCloud(
        showBorder: true,
        size: width,
        droppingType: DroppingType.snow,
        droppingLevel: DroppingLevel.medium,
        borderDecoration: BoxDecoration(color: Colors.lightBlueAccent),
        cloudColor: Colors.white,
        droppingColor: Colors.white,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: Container(
        alignment: Alignment.center,
        child: Hero(tag: "weather_${index}", child: weathers[index]),
      ),
    );
  }

}
