import 'dart:io';

import 'package:flutter/material.dart';
import 'file_util.dart';

class HistoryPage extends StatelessWidget {
  final String path;

  const HistoryPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史"),
      ),
      body: Container(
        child: FutureBuilder(
            future: FileUtil.getInstance().getDirChildren(path),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<String> datas = snapshot.data;
                return ListView(
                  children: List.generate((datas.length), (index) {
                    return Container(
                      margin: EdgeInsets.all(50),
                      child: Image.file(File(datas[index])),
                    );
                  }),
                );
              } else
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                );
            }),
      ),
    );
  }
}
