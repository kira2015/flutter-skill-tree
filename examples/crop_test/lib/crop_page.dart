import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:path_provider/path_provider.dart';

import 'file_util.dart';
import 'history_page.dart';

class CropPage extends StatefulWidget {
  final String imageUrl;

  const CropPage({Key key, this.imageUrl}) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  final cropKey = GlobalKey<CropState>();

  @override
  void dispose() {
    cropKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("裁剪"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.history), onPressed: () async{
            String newPath = await FileUtil.getInstance().getSavePath('/crop/');

            Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                return HistoryPage(path: newPath,);
            }));
          })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Crop(
              key: cropKey,
              image: FileImage(File(widget.imageUrl)),
              aspectRatio: 1.0,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              highlightColor: Theme.of(context).primaryColorLight,
              colorBrightness: Brightness.dark,
              splashColor: Theme.of(context).primaryColorDark,
              child: Text("保存"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () => onSaveTap(widget.imageUrl),
            ),
          )
        ],
      ),
    );
  }


  void onSaveTap(String originPath) async{

    String path = await FileUtil.getInstance().getSavePath('/crop/');
    String name = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final croppedFile = await ImageCrop.cropImage(
      file: File(originPath),
      area: cropKey.currentState.area,
    );

    File newFile = croppedFile.copySync(path + name);

    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
      return HistoryPage(path: path,);
    }));
  }

}
