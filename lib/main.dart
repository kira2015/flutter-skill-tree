import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:skill_tree/splash_page.dart';

import 'home_page.dart';

void main() {
  ///高德地图定位
  AMapLocationClient.setApiKey("60600f655cb28db0a16580efb34a75d3");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Skill Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

