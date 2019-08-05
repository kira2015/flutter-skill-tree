import 'dart:math';

import 'package:flutter/material.dart';

class WeatherDropping extends StatefulWidget {
  final double droppingWidth;
  final double droppingHeight;
  final Color droppingColor;
  final Duration animationDuration;
  final DroppingLevel droppingLevel;
  final DroppingType droppingType;
  final Widget droppingWidget;
  final bool showBorder;
  final Decoration borderDecoration;

  const WeatherDropping({
    Key key,
    this.droppingColor,
    this.animationDuration,
    this.droppingLevel = DroppingLevel.small,
    this.droppingWidth = 100,
    this.droppingHeight = 50,
    this.droppingWidget,
    this.droppingType = DroppingType.rain,
    this.showBorder = false,
    this.borderDecoration,
  }) : super(key: key);

  @override
  _WeatherDroppingState createState() => _WeatherDroppingState();
}

class _WeatherDroppingState extends State<WeatherDropping>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration ?? Duration(seconds: 10));
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
    final children =
        getDroppingWidget(widget.droppingHeight, widget.droppingWidth, context);

    return Container(
      width: widget.droppingWidth,
      height: widget.droppingHeight,
      decoration:
          widget.showBorder ? (widget.borderDecoration ?? BoxDecoration(border: Border.all())) : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (ctx, child) {
          return ClipRect(
            clipper: CustomRect(),
            child: Transform.translate(
              offset: Offset(
                0,
                _animation.value * widget.droppingHeight,
              ),
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, -widget.droppingHeight),
              child: Stack(
                children: children,
              ),
            ),
            Stack(
              children: children,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getDroppingWidget(double height, double width, BuildContext context) {
    int randomNum = 0;
    switch (widget.droppingLevel) {
      case DroppingLevel.big:
        randomNum = 150;
        break;
      case DroppingLevel.medium:
        randomNum = 100;
        break;
      case DroppingLevel.small:
        randomNum = 50;
        break;
    }

    List<Widget> list = List.generate(randomNum, (index) {
      //雨滴随机大小
      final randomWidth = Random().nextDouble() * width / 50 + 1;
      final randomHeight = Random().nextDouble() * height / 10;
      //雨滴随机坐标
      double randomL = Random().nextDouble() * width - randomWidth;
      double randomT = Random().nextDouble() * height + randomHeight;
      //防止出现图形被切割的情况
      if(randomT < (randomHeight + randomWidth) *2){
        randomT = (randomHeight + randomWidth) * 2;
      } else if(randomT > height - (randomHeight + randomWidth) * 2) {
        randomT = height - (randomHeight + randomWidth) * 2;
      }
      return Positioned(
        child: getDroppingType(
            randomWidth, randomHeight, context, widget.droppingType),
        left: randomL - width * _animation.value,
        top: randomT + height * _animation.value,
      );
    });
    return list;
  }

  Widget getDroppingType(
    double randomWidth,
    double randomHeight,
    BuildContext context,
    DroppingType type,
  ) {
    if (widget.droppingWidget != null) {
      return Container(
        width: randomWidth,
        height: randomHeight,
        child: widget.droppingWidget,
      );
    }
    switch (type) {
      case DroppingType.rain:
        return Container(
          width: randomWidth,
          height: randomHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(randomWidth / 2)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    widget.droppingColor ?? Theme.of(context).primaryColor,
                  ])),
        );
      case DroppingType.snow:
        double width = randomWidth + randomHeight * Random().nextDouble();
        return Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    widget.droppingColor ?? Theme.of(context).primaryColor,
                  ])),
        );
        break;
    }
  }
}

enum DroppingLevel {
  small,
  medium,
  big,
}

enum DroppingType {
  rain,
  snow,
}

class CustomRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return false;
  }
}
