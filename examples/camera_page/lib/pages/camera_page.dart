import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera_page/pages/pic_list_page.dart';
import 'package:camera_page/pages/video_list_page.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    controller.addListener(() {
      setState(() {
        debugPrint("正在录像?:${controller?.value?.isRecordingVideo}");
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      );
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "1",
                  onPressed: () async {
                    bool permissionPass = await requestPermission();

                    if (permissionPass  || Platform.isIOS) {
                      String path = await getPath("/pic/");
                      final savePath = path +
                          "pic${DateTime.now().millisecondsSinceEpoch}.jpg";
                      await controller.takePicture(savePath);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Text("请打开读写权限"),
                            );
                          });
                    }
                  },
                  child: Icon(Icons.camera_alt)),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                  heroTag: "2",
                  onPressed: () async {
                    bool permissionPass = await requestPermission();

                    if (permissionPass || Platform.isIOS) {
                      String path = await getPath("/video/");
                      final savePath = path +
                          "video${DateTime.now().millisecondsSinceEpoch}.mp4";
                      if (controller.value.isRecordingVideo) {
                        controller.stopVideoRecording();
                      } else {
                        await controller.startVideoRecording(savePath);
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Text("请打开读写权限"),
                            );
                          });
                    }
                  },
                  child: Icon(controller.value.isRecordingVideo
                      ? Icons.videocam_off
                      : Icons.videocam)),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                  heroTag: "3",
                  onPressed: () {
                    openPicListPage(context);
                  },
                  child: Icon(Icons.image)),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                  heroTag: "4",
                  onPressed: () {
                    if (controller.value.isRecordingVideo) {
                      controller.stopVideoRecording();
                    }
                    openVideoListPage(context);
                  },
                  child: Icon(Icons.video_library)),
            ],
          ),
          appBar: AppBar(
            title: Text("相机测试"),
          ),
          body: CameraPreview(controller),
        ));
  }

  Future<bool> requestPermission() async {
     Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.storage]);
    return permissions[PermissionGroup.storage] == PermissionStatus.granted;
  }

  void openVideoListPage(BuildContext context) async {
    String path = await getPath("/video/");
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;
      if (filename.contains(".mp4")) {
        pathList.add(o.path);
      }
    }
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return VideoListPage(pathList);
    }));
  }

  void openPicListPage(BuildContext context) async {
    String path = await getPath("/pic/");
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;
      if (filename.contains(".jpg")) {
        pathList.add(o.path);
      }
    }
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return PicListPage(pathList);
    }));
  }

  Future<String> getPath(String endPath) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path = tempDir.path + endPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return path;
  }
}
