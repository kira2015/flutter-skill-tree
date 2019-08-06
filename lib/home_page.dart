import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skill_tree/audio_play/home_audio_page.dart';
import 'package:skill_tree/auto_size_text/auto_size_text_home.dart';
import 'package:skill_tree/download/download_home.dart';
import 'package:skill_tree/drag_list/drag_list_home.dart';
import 'package:skill_tree/file_path/file_path_home.dart';
import 'package:skill_tree/location/location_home.dart';
import 'package:skill_tree/move_widget/move_widget.dart';
import 'package:skill_tree/permission/permission_home.dart';
import 'package:skill_tree/camera/camera_home.dart';
import 'package:skill_tree/photos/photos_home.dart';
import 'package:skill_tree/qr_code/qr_code_home.dart';
import 'package:skill_tree/share/home_share_page.dart';
import 'package:skill_tree/video_player/video_player.dart';

import 'animation/home_animation_page.dart';
import 'image_crop/home_crop_page.dart';

class MyHomePage extends StatelessWidget {
  final Map<Map<String, Widget>, IconData> mapList = {
    {"相机": CameraExampleHome()}: Icons.camera_alt,
    {"权限申请": PermissionHomePage()}: Icons.widgets,
    {"数据存取": FilePathHome()}: Icons.insert_drive_file,
    {"相册": PhotosHome()}: Icons.photo,
    {"录音": HomeAudioPage()}: Icons.mic,
    {"定位": LocationHome()}: Icons.mic,
    {"自适应文本": AutoTextHome()}: Icons.text_fields,
    {"拖拽控件": MoveWidgetHome()}: Icons.compare_arrows,
    {"下载": DownloadHome()}: Icons.cloud_download,
    {"二维码": QRCodeHome()}: Icons.blur_on,
    {"天气动画": HomeAnimationPage()}: Icons.wb_sunny,
    {"分享": HomeSharePage()}: Icons.share,
    {"图片裁剪": HomeCropPage()}: Icons.crop_free,
    {"拖拽列表": DragListHome()}: Icons.format_list_bulleted,
    {"视频播放": VideoPlayerHome()}: Icons.video_library
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizonCardNum = size.width ~/ 100;
    final space = 20.0;
    final cardSize = size.width / horizonCardNum - space;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '功能点列表',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: space,
            children: List.generate(mapList.length, (index) {
              final iconData = mapList.values.toList()[index];
              final map = mapList.keys.toList()[index];
              final name = map.keys.first;
              final page = map.values.first;

              return Container(
                margin: EdgeInsets.only(top: space),
                width: cardSize,
                height: cardSize,
                child: InkWell(
                  onTap: () => pushNewPage(page, context),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(cardSize / 5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          iconData,
                          size: cardSize / 4,
                        ),
                        SizedBox(
                          height: cardSize / 10,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: cardSize / 8),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void pushNewPage(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
