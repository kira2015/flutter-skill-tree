import 'package:animation_test/widgets/weather_dropping.dart';
import 'package:flutter/material.dart';

class WeatherDropWithCloud extends StatelessWidget {
  final double size;
  final Color cloudColor;
  final Color droppingColor;
  final bool showBorder;
  final DroppingType droppingType;
  final DroppingLevel droppingLevel;
  final Decoration borderDecoration;
  final Widget droppingWidget;


  const WeatherDropWithCloud(
      {Key key,
      this.size = 100,
      this.cloudColor = Colors.blueGrey,
      this.droppingColor = Colors.blueAccent,
      this.showBorder = false,
      this.borderDecoration, this.droppingType = DroppingType.rain, this.droppingLevel = DroppingLevel.small, this.droppingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cloudSize = size * 0.8;
    final dropSize = cloudSize * 0.8;
    final origin = Offset(size / 2, size / 2);

    final cloudOrigin =
        Offset(origin.dx - cloudSize / 2, origin.dy - cloudSize / 2);
    final droppingOrigin =
        Offset(origin.dx - dropSize / 2, origin.dy - dropSize / 4);

    return Container(
      width: size,
      height: size,
      decoration: showBorder
          ? (borderDecoration ?? BoxDecoration(border: Border.all()))
          : null,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: cloudOrigin.dx,
            top: - cloudSize * 0.1,
            child: Icon(
              Icons.cloud,
              size: cloudSize,
              color: cloudColor,
            ),
          ),
          Positioned(
            left: droppingOrigin.dx,
            top: droppingOrigin.dy + dropSize / 4 + cloudSize * 0.1,
            child: WeatherDropping(
              droppingHeight: dropSize / 2,
              droppingWidth: dropSize,
              droppingColor: droppingColor ?? Colors.lightBlue,
              droppingLevel: droppingLevel,
              droppingType: droppingType,
              droppingWidget: droppingWidget,
            ),
          ),
        ],
      ),
    );
  }
}
