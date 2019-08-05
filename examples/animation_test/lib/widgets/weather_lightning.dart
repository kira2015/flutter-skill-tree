import 'dart:math';

import 'package:flutter/material.dart';

class WeatherLightning extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final Duration duration;
  final bool showBorder;
  final Decoration borderDecoration;
  final LightningLevel level;

  const WeatherLightning(
      {Key key,
      this.color = Colors.black,
      this.duration,
      this.showBorder = false,
      this.borderDecoration,
      this.width = 100,
      this.height = 100,
      this.level = LightningLevel.small})
      : super(key: key);

  @override
  _WeatherLightningState createState() => _WeatherLightningState();
}

class _WeatherLightningState extends State<WeatherLightning>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  Color animationColor = Colors.white;


  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(animation.value * 60)

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.showBorder
          ? (widget.borderDecoration ?? BoxDecoration(border: Border.all()))
          : null,
      child: Stack(
        children: getLightnings(animationColor),
      ),
    );
  }

  List<Widget> getLightnings(Color color) {
    final origin = Offset(widget.width / 2, widget.height / 2);
    final lightningSize = min(widget.width, widget.height) / 2;
    final lightningOrigin =
        Offset(origin.dx - lightningSize / 2, origin.dy - lightningSize / 2);

    switch (widget.level) {
      case LightningLevel.small:
        return [
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: lightningSize,
              color: widget.color,
            ),
            top: lightningOrigin.dy,
            left: lightningOrigin.dx,
          ),
        ];
        break;
      case LightningLevel.medium:
        return [
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: lightningSize,
              color: color,
            ),
            top: lightningOrigin.dy,
            left: lightningOrigin.dx - lightningSize / 2,
          ),
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: lightningSize,
              color: color,
            ),
            top: lightningOrigin.dy,
            left: lightningOrigin.dx + lightningSize / 2,
          ),
        ];
        break;
      case LightningLevel.big:
        final bigLevelSize = lightningSize * 2 / 3;
        final bigLevelOrigin =
            Offset(origin.dx - bigLevelSize / 2, origin.dy - bigLevelSize / 2);

        return [
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: bigLevelSize,
              color: color,
            ),
            top: bigLevelOrigin.dy - bigLevelSize / 2,
            left: bigLevelOrigin.dx,
          ),
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: bigLevelSize,
              color: color,
            ),
            top: bigLevelOrigin.dy + bigLevelSize / 2,
            left: bigLevelOrigin.dx - bigLevelSize / 2,
          ),
          Positioned(
            child: Icon(
              Icons.flash_on,
              size: bigLevelSize,
              color: color,
            ),
            top: bigLevelOrigin.dy + bigLevelSize / 2,
            left: bigLevelOrigin.dx + bigLevelSize / 2,
          ),
        ];
        break;
    }
  }
}

enum LightningLevel {
  small,
  medium,
  big,
}
