import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomeSharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分享"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
          child: Text("分享测试"),
          onPressed: () {
            Share.share('check out my website https://example.com',);
          },
        ),
      ),
    );
  }
}
