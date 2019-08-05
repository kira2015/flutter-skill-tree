import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_page/pages/image_page.dart';

class PicListPage extends StatelessWidget {
  final List<String> picPaths;

  PicListPage(this.picPaths);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片预览"),
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Wrap(
        children: List.generate(picPaths.length, (index) {
            return Container(
              margin: EdgeInsets.all(10),
              width: 150,
              height: 150,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                      return ImagePage(imagePath: picPaths[index],index: index,);
                  }));
                },
                child: Image.file(File(picPaths[index])),
              ),
            );
        }),
      ),
          )),
    );
  }
}
