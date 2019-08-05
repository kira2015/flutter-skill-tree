
import 'package:flutter/material.dart';
import 'package:skill_tree/animation/widgets/all_weathers.dart';
import 'package:skill_tree/animation/widgets/lightning_widget.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width / 2 - 20.0;
    return Scaffold(
      appBar: AppBar(title: Text("动画界面"),),
      body: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
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
                borderDecoration: BoxDecoration(
                  color: Colors.black
                ),
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
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: CustomPaint(
                  size: Size(width, width), //指定画布大小
                  painter: LightningWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
