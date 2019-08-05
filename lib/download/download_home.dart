import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DownloadHome extends StatefulWidget {
  @override
  _DownloadHomeState createState() => _DownloadHomeState();
}

class _DownloadHomeState extends State<DownloadHome> {
  ProgressDialog _progressDialog;
  String taskId;
  String taskIdTwo;
  String path;

  //是否隐藏
  bool _isHidden = true;
  double _progressNum = 0.0;
  String _downloadStatusStr = '下载中...';
  bool _isPause = false;

  @override
  void initState() {
    //全局进度弹框
    _progressDialog = ProgressDialog(context, ProgressDialogType.Download);

    //监听下载回调
    FlutterDownloader.registerCallback((id, status, progress) {
      //全局弹框
      if (id == taskId) {
        //展示进度弹框
        _progressDialog.isShowing() ? null : _progressDialog.show();

        if (status == DownloadTaskStatus.running) {
          print('running');
          _progressDialog.update(
            progress: progress.toDouble(),
            message: '努力下载中...',
          );
        }

        if (status == DownloadTaskStatus.complete) {
          print('路径：$path');
          //完成
          _progressDialog.isShowing() ? _progressDialog.hide() : null;
          Fluttertoast.showToast(msg: '完成下载\n路径：$path');
        }
      } else {
        if (status == DownloadTaskStatus.running) {
          print('running--$progress');
          _progressNum = progress.toDouble();
          _downloadStatusStr = '下载中...';
        }
        if (status == DownloadTaskStatus.canceled) {
          print('canceled');
          //取消
          _progressNum = 0.0;
          _downloadStatusStr = '任务已取消';
        }
        if (status == DownloadTaskStatus.complete) {
          print('路径：$path');
          //完成
          _downloadStatusStr = '完成下载';
          Fluttertoast.showToast(msg: '完成下载\n路径：$path');
        }
        if (status == DownloadTaskStatus.paused) {
          print('paused');
          _downloadStatusStr = '暂停下载';
          Fluttertoast.showToast(msg: '暂停成功');
          //暂停

        }
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载功能'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(
                  Icons.file_download,
                  size: 20,
                ),
                label: Text('新建下载任务'),
                onPressed: () {
                  _isHidden = false;
                  getTaskTwo();
                  setState(() {});
                },
              ),
              RaisedButton.icon(
                icon: Icon(
                  _isPause ? Icons.play_circle_outline : Icons.pause,
                  size: 20,
                ),
                label: _isPause ? Text('恢复下载') : Text('暂停下载'),
                onPressed: () {
                  if (taskIdTwo == null) {
                    Fluttertoast.showToast(msg: '还未启动下载任务');
                    return;
                  }
                  _isPause ? resumeTask() : pauseTask();
                  _isPause = !_isPause;
                },
              ),
              RaisedButton.icon(
                icon: Icon(
                  Icons.cancel,
                  size: 20,
                ),
                label: Text('取消下载'),
                onPressed: () {
                  taskIdTwo != null
                      ? FlutterDownloader.cancel(taskId: taskIdTwo)
                      : Fluttertoast.showToast(msg: '没有任务可以取消');
                },
              ),
            ],
          ),
          Offstage(
            offstage: _isHidden,
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              percent: _progressNum / 100,
              center: new Text(
                "${_progressNum.toInt()}%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                _downloadStatusStr,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    getTask();
                  },
                  child: Text('全局弹框的下载'),
                ),
                RaisedButton(
                  onPressed: () {
                    FlutterDownloader.remove(taskId: taskId,shouldDeleteContent: true);
                    FlutterDownloader.remove(taskId: taskIdTwo,shouldDeleteContent: true);
                  },
                  child: Text('移除所有下载任务'),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Future<String> getDocPath() async {
    var docDir = await getApplicationDocumentsDirectory();
    String pathDoc = docDir.path + '/download';
    final targetPath = Directory(pathDoc);
    if (!await targetPath.exists()) {
      targetPath.create();
    }
    return pathDoc;
  }

//下载的配置并执行
  getTask() async {
    path = await getDocPath();
    taskId = await FlutterDownloader.enqueue(
      url:'https://dldir1.qq.com/qqfile/qq/PCQQ9.1.5/25530/QQ9.1.5.25530.exe',
      savedDir: path,
    );

    await FlutterDownloader.loadTasksWithRawQuery(query: taskId);
  }

  getTaskTwo() async {
    path = await getDocPath();
    taskIdTwo = await FlutterDownloader.enqueue(
      url:'https://dldir1.qq.com/qqfile/qq/PCQQ9.1.5/25530/QQ9.1.5.25530.exe',
      savedDir: path,
    );

    await FlutterDownloader.loadTasksWithRawQuery(query: taskIdTwo);
  }

  void resumeTask() async {
    taskIdTwo = await FlutterDownloader.resume(taskId: taskIdTwo);
  }

  void pauseTask() async {
    
    await FlutterDownloader.pause(taskId: taskIdTwo);
  }
}
