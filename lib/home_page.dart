import 'dart:io';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<CameraDescription> cameras;

void getCameras() async {
  cameras = await availableCameras();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //获取手机的摄像头
    getCameras();
    super.initState();
  }

  final List skills = [
    '1.相机camera',
    '2.权限申请permission',
    '3.本地数据存取file_path',
    '4.相册photos',
    '5.录音audio',
    '6.快速定位location',
    '7.自动适应的文本与键盘auto_size_text',
    '8.拖动控件move_widget',
    '9.下载download',
    '10.二维码qr_code',
    '11.天气动画animation',
    '12.分享share',
    '13.图片裁剪crop',
    '14.列表数据拖动drag_list',
    '15.视频播放video_player',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功能点列表'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(skills[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => tapList(index, context),
          );
        },
        itemCount: skills.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 5,
          );
        },
      ),
    );
  }
}

void tapList(int index, context) {
  print(index);
  switch (index) {
    case 0:
      //相机
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CameraExampleHome(cameras);
      }));
      break;
    case 1:
      //权限申请
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PermissionHomePage();
      }));
      break;
    case 2:
      //文件储存与读取
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FilePathHome();
      }));
      break;
    case 3:
      //相册
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PhotosHome();
      }));
      break;
    case 4:
      //录音
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeAudioPage();
      }));
      break;
    case 5:
      //快速定位
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationHome();
      }));
      break;
    case 6:
      //自动缩放的文本
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AutoTextHome();
      }));
      break;
    case 7:
      //拖动
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MoveWidgetHome();
      }));
      break;
    case 8:
      //下载
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DownloadHome();
      }));
      break;
    case 9:
      //二维码
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return QRCodeHome();
      }));
      break;

    case 10:
      //自定义动画
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return HomeAnimationPage();
      }));
      break;
    case 11:
      //分享
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return HomeSharePage();
      }));
      break;
    case 12:
      //图片裁剪
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return HomeCropPage();
      }));
      break;
    case 13:
      //拖动列表数据
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return DragListHome();
      }));
      break;
    case 14:
      //视频播放
      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
        return VideoPlayerHome();
      }));
      break;
    default:
  }
}
