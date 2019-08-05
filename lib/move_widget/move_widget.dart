import 'dart:math';

import 'package:flutter/material.dart';

class MoveWidgetHome extends StatefulWidget {
  @override
  _MoveWidgetHomeState createState() => _MoveWidgetHomeState();
}

class _MoveWidgetHomeState extends State<MoveWidgetHome> {
  List<Widget> movableItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              movableItems.add(MoveableStackItem());
            });
          },
        ),
        appBar: AppBar(
          title: Text('拖动控件'),
        ),
        body: Stack(
          children: movableItems,
        ));
  }
}

class MoveableStackItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color;

  double _width = 150;

  @override
  void initState() {
    color = getRandomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onTap: () {
          _width = Random().nextInt(250) + 50.0;
          print('点击--$_width');
          setState(() {});
        },
        // onVerticalDragUpdate: (pos) {
        //   print("拖拽更新----(x,y):(${pos.globalPosition.dx},${pos.globalPosition.dy})");
        //       setState(() {
        //     yPosition = pos.globalPosition.dy-175;
        //     xPosition = pos.globalPosition.dx-75;

        //   });
        // },

        onPanUpdate: (DragUpdateDetails tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: AnimatedContainer(
          width: _width,
          height: _width,
          color: color,
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}

getRandomColor() {
  return Color.fromARGB(
    255,
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
  );
}
