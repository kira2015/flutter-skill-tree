import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeHome extends StatefulWidget {
  @override
  _QRCodeHomeState createState() => _QRCodeHomeState();
}

class _QRCodeHomeState extends State<QRCodeHome> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  String barcode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('二维码使用'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              child: RaisedButton(
                  onPressed: () {
                    getCodeStr();
                  },
                  child: new Text("扫描二维码")),
              padding: const EdgeInsets.all(8.0),
            ),
            Align(alignment: Alignment(0, 0), child: Text(barcode)),
            Container(child: Text('---输入内容生成二维码---'),margin: EdgeInsets.only(top: 30),),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: '输入你要生成二维码的内容',
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          print('更新');
                          setState(() {});
                        },
                      ), // myIcon is a 48px-wide widget.
                    )),
              ),
            ),
            Offstage(
              offstage: _textEditingController.text.length==0 ? true : false,
              child: QrImage(
                data: _textEditingController.text,
                size: 200.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  void getCodeStr() async {
    String str = await FlutterBarcodeScanner.scanBarcode("#ff6600", "取消", true);
    barcode = str;
    setState(() {});
  }

//连续扫描
  void getCodeMultiStr() {
    FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff3300", "取消", true)
        .listen(
      (barcode) {
        print('回调二维码：$barcode');
        this.barcode = barcode;
        setState(() {});
      },
    );
  }
}
