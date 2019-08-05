import 'package:animation_test/pages/single_weather_page.dart';
import 'package:animation_test/widgets/all_weathers.dart';
import 'package:animation_test/widgets/lightning_widget.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  final List<String> names = [
    "阴",
    "晴",
    "雨",
    "雪",
    "云雨",
    "云雪",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width / 2 - 20.0;

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
//      Container(
//        decoration: BoxDecoration(border: Border.all()),
//        child: CustomPaint(
//          size: Size(width, width), //指定画布大小
//          painter: LightningWidget(),
//        ),
//      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("动画界面"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(weathers.length, (index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                      return SingleWeatherPage(
                        names[index], index,
                      );
                  }));
                },
                child: Hero(
                  tag: "weather_${index}",
                  child: weathers[index],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
