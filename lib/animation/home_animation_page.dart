
import 'package:flutter/material.dart';
import 'package:skill_tree/animation/pages/weather_page.dart';

class HomeAnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画测试"),
      ),
      body: Container(
          alignment: Alignment.center,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (ctx) {
                return WeatherPage();
              }));
            },
            child: Text("观看动画"),
          )),
    );
  }
}
