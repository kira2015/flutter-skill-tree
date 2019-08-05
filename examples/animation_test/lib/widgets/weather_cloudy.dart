import 'package:animation_test/widgets/weather_sunny.dart';
import 'package:flutter/material.dart';
import 'dart:math';

export '../icon_type.dart';

class WeatherCloudy extends StatelessWidget {
  final double height;
  final double width;
  final Color cloudColor;
  final Color sunColor;
  final bool showBorder;
  final Decoration borderDecoration;

  const WeatherCloudy({
    Key key,
    this.height = 24,
    this.width = 24,
    this.cloudColor = Colors.blueGrey,
    this.sunColor = Colors.orange,
    this.showBorder = false, this.borderDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconWidth = width / 7 * 6;
    final iconHeight = height / 7 * 6;
    final cloudSize = min(iconWidth, iconHeight);
    final sunSize = cloudSize / 5 * 4;

    final origin = Offset(width / 2, height / 2);
    final sunOrigin = Offset(origin.dx - sunSize / 2, origin.dy - sunSize / 2);
    final cloudOrigin =
        Offset(origin.dx - cloudSize / 2, origin.dy - cloudSize / 2);

    return Container(
      width: width,
      height: height,
      decoration: showBorder ? (borderDecoration ?? BoxDecoration(border: Border.all())) : null,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: sunOrigin.dx + cloudSize / 6,
            top: sunOrigin.dy - cloudSize / 6,
            child: WeatherSunny(
              sunnySize: sunSize,
              sunColor: sunColor,
            ),
          ),
          Positioned(
            left: cloudOrigin.dx,
            top: cloudOrigin.dy,
            child: Icon(
              Icons.cloud,
              size: cloudSize,
              color: cloudColor,
            ),
          ),
        ],
      ),
    );
  }
}
