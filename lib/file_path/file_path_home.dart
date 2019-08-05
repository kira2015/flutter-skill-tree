import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FilePathHome extends StatefulWidget {
  @override
  _FilePathHomeState createState() => _FilePathHomeState();
}

class _FilePathHomeState extends State<FilePathHome> {
  TextEditingController textEditingController;
  FocusNode contentFocusNode = FocusNode();
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '本地数据存取',
      )),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.input),
                  label: Text('写入'),
                  onPressed: () {
                    contentFocusNode.unfocus();
                    textEditingController.text.length > 0
                        ? writeData(textEditingController.text)
                        : Fluttertoast.showToast(msg: '内容不能为空');
                  },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.looks),
                  label: Text('读取'),
                  onPressed: () {
                    contentFocusNode.unfocus();
                    readData();
                  },
                ),
              ],
            ),
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: '请输入要存储的内容'),
            focusNode: contentFocusNode,
          ),
        ],
      ),
    );
  }
}

Future<String> getDocPath() async {
  var docDir = await getApplicationDocumentsDirectory();
  String pathDoc = docDir.path;
  return pathDoc;
}

void readData() async {
  try {
    String targetPath = await getDocPath() + '/data';
    final dataFile = File(targetPath);
    if (dataFile.exists() != null) {
      print('非空');
    }
    if (await dataFile.exists()) {
      var dataJson = await dataFile.readAsString();
      print(dataJson);
      Fluttertoast.showToast(
          timeInSecForIos: 3, msg: '内容$dataJson\n路径：$targetPath');
    } else {
      Fluttertoast.showToast(timeInSecForIos: 2, msg: '文件不存在');
    }
  } catch (e) {
    Fluttertoast.showToast(timeInSecForIos: 5, msg: '读取失败\n$e');
  }
}

void writeData(String content) async {
  try {
    String targetPath = await getDocPath() + '/data';
    final dataFile = File(targetPath);
    dataFile.writeAsString(content);
    Fluttertoast.showToast(msg: '写入成功\n路径：$targetPath', timeInSecForIos: 2);
  } catch (e) {
    Fluttertoast.showToast(timeInSecForIos: 5, msg: '写入失败\n$e');
  }
}
