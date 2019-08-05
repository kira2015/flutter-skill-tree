import 'dart:io';

import 'package:crop_test/crop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';

import 'file_util.dart';

class HomeCropPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片裁剪"),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(10, (index) {
            return InkWell(
              onTap: () async{
               final path = await onSave( "images/","${index + 1}.png");
               debugPrint("file:${path}   存在:${File(path).existsSync()}" );
                Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                    return CropPage(
                      imageUrl: path,
                    );
                }));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Hero(
                    tag: "avatar${index}",
                    child: Image.asset(
                      "images/${index + 1}.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }


  //将asset文件存储为file
  Future<String> onSave(String assetPath, String assetName) async{

    String path = await FileUtil.getInstance().getSavePath('/avatar/');

    bool exists = await new File(path + assetName).exists();
    if (!exists) {
      var data = await rootBundle.load(assetPath + assetName);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path + assetName).writeAsBytes(bytes);
      return path + assetName;
    } else return path + assetName;
  }
}
