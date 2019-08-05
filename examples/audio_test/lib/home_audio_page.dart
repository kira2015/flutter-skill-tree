import 'dart:async';
import 'dart:io';

import 'package:audio_test/pages/audio_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeAudioPage extends StatefulWidget {
  @override
  _HomeAudioPageState createState() => _HomeAudioPageState();
}

class _HomeAudioPageState extends State<HomeAudioPage> {
  bool isRecording = false;
  String recordingTime = "00:00:00";
  FlutterSound flutterSound;
  SoundModel soundModel;
  List<String> localFilePaths = [];

  @override
  void initState() {
    super.initState();
    flutterSound = FlutterSound();
    soundModel = SoundModel();
    getSavePath("/audio/").then((path) {
      getDirChildren(path).then((list) {
        localFilePaths.clear();
        localFilePaths.addAll(list);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    soundModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: isRecording ? stopRecord : requestPermission,
            child: Icon(isRecording ? Icons.mic_off : Icons.mic),
          ),
          SizedBox(
            width: 5,
          ),
          Text(recordingTime)
        ],
      ),
      appBar: AppBar(
        title: Text("录音"),
      ),
      body: Container(
        child: FutureBuilder(
            future: null,
            builder: (context, snapshot) {
              return ListView(
                children: List.generate(localFilePaths.length, (index) {
                  return ListTile(
                    leading: Icon(Icons.mic_none),
                    title: Text(localFilePaths[index].split("/").last),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                          return AudioPlayPage(path:localFilePaths[index]);
                      }));
                    },
                  );
                }),
              );
            }),
      ),
    );
  }

  void startRecord() async {
    if (isRecording) return;
    isRecording = true;
    String path = await getSavePath("/audio/");
    String savePath = path + "${DateTime.now().millisecondsSinceEpoch}.m4a";
    await flutterSound.startRecorder(savePath);
    soundModel.recorderSubscription =
        flutterSound.onRecorderStateChanged.listen((RecordStatus rs) {
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(
          rs.currentPosition.toInt(),
          isUtc: true);
      setState(() {
        recordingTime = transformTime(date);
      });
    });
  }

  void stopRecord() async {
    try {
      String result = await flutterSound.stopRecorder();
      soundModel.dispose();
      final path = await getSavePath("/audio/");
      final dirChildren = await getDirChildren(path);
      setState(() {
        isRecording = false;
        recordingTime = "00:00:00";
        localFilePaths.clear();
        localFilePaths.addAll(dirChildren);
      });
    } catch (err) {
      print('停止出错: $err');
    }
  }

  Future<String> getSavePath(String endPath) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path = tempDir.path + endPath;
    Directory directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return path;
  }

  Future<List<String>> getDirChildren(String path) async {
    Directory directory = Directory(path);
    final childrenDir = directory.listSync();
    List<String> pathList = [];
    for (var o in childrenDir) {
      final filename = o.path.split("/").last;
      if (filename.contains(".")) {
        pathList.add(o.path);
      }
    }
    return pathList;
  }

  String transformTime(DateTime date) {
    int mSecond = (date.millisecond / 10).toInt();
    int second = date.second;
    int minute = date.minute;
    int hour = date.hour;
    String theHour = hour < 10 ? "0${hour}" : "${hour}";
    String theMinute = minute < 10 ? "0${minute}" : "${minute}";
    String theSecond = second < 10 ? "0${second}" : "${second}";
    String themSecond = mSecond < 10 ? "0${mSecond}" : "${mSecond}";
    return theMinute + ":" + theSecond + ":" + themSecond;
  }

  void requestPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(
            [PermissionGroup.storage, PermissionGroup.microphone]);
    if (permissions[PermissionGroup.storage] == PermissionStatus.denied ||
        permissions[PermissionGroup.microphone] == PermissionStatus.denied) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("权限被拒绝"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      PermissionHandler().openAppSettings();
                    },
                    child: Text("打开设置页面")),
              ],
            );
          });
      return;
    } else {
      startRecord();
    }
  }
}

class SoundModel {
  StreamSubscription recorderSubscription;
  StreamSubscription dbPeakSubscription;
  StreamSubscription playerSubscription;

  void dispose() {
    recorderSubscription?.cancel();
    dbPeakSubscription?.cancel();
    playerSubscription?.cancel();
  }
}
