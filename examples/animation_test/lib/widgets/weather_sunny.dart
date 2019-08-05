import 'dart:math';

import 'package:flutter/material.dart';

class WeatherSunny extends StatefulWidget {
  final double sunnySize;
  final Color sunColor;
  final Duration animationDuration;
  final bool showBorder;
  final Decoration borderDecoration;

  const WeatherSunny({
    Key key,
    this.sunnySize = 100,
    this.sunColor = Colors.orange,
    this.animationDuration,
    this.showBorder = false,
    this.borderDecoration,
  }) : super(key: key);

  @override
  _WeatherSunnyState createState() => _WeatherSunnyState();
}

class _WeatherSunnyState extends State<WeatherSunny>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(seconds: 60),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Container(
          decoration: widget.showBorder
              ? (widget.borderDecoration ?? BoxDecoration(border: Border.all()))
              : null,
          child: Transform.rotate(
            angle: pi * 2 * _animation.value * 5,
            child: child,
          ),
        );
      },
      child: Icon(
        Icons.wb_sunny,
        size: widget.sunnySize,
        color: widget.sunColor,
      ),
    );
  }
}
