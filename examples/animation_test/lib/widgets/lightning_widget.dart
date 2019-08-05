import 'dart:math';

import 'package:flutter/material.dart';

class LightningWidget extends CustomPainter {
  final Color lightningColor;

  LightningWidget({this.lightningColor = Colors.blueAccent});

  @override
  void paint(Canvas canvas, Size size) {

    final startOffset = Offset(Random().nextInt((size.width / 2).toInt()).toDouble(), 0);

    final paint = Paint()
      ..color = lightningColor
      ..strokeWidth = min(size.width, size.height) / 300
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    Path path = Path()
      ..moveTo(startOffset.dx, 0)
    ..lineTo(startOffset.dx, startOffset.dy);

    getNextPath(path, startOffset, true, size.width,size.height);
    path.moveTo(startOffset.dx, startOffset.dy);
    getNextPath(path, startOffset, false, size.width,size.height);


    canvas.drawPath(path, paint);


    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    debugPrint("重新绘制");
    return false;
  }


  void getNextPath(Path path, Offset oldPoint, bool isLeft, double width, double height,{bool isBranch = false}){
    double positive = Random().nextBool() ? -1 : 1;
    double newX = Random().nextDouble() * width / 5 * positive + oldPoint.dx;
    double newY = Random().nextDouble() * height / 5 + oldPoint.dy;
    if(newY >= height) return;
    if(isLeft && newX <= 0) return;
    if(!isLeft && newX >= width) return;

    bool painBranch = Random().nextBool();
    if(painBranch){
      path.moveTo(oldPoint.dx, oldPoint.dy);
      getNextPath(path, Offset(newX, newY), isLeft, width / 2,height / 2, isBranch: painBranch);
      path.moveTo(oldPoint.dx, oldPoint.dy);


    }
    path.lineTo(newX, newY);
    getNextPath(path, Offset(newX, newY), isLeft, width,height);
  }


}
