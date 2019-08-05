import 'package:flutter/material.dart';
import 'dart:io';

class ImagePage extends StatelessWidget {

  final String imagePath;
  final int index;

  const ImagePage({Key key, this.imagePath, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("照片${index}"),),
      body: Container(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
