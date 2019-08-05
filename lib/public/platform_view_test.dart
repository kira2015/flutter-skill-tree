import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformViewTest {
  static const MethodChannel _channel =
      const MethodChannel('platform_view_test');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

class MyIosView extends StatefulWidget {
  @override
  _MyIosViewState createState() => _MyIosViewState();
}

class _MyIosViewState extends State<MyIosView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
          viewType: 'myid',
          onPlatformViewCreated: _onPlatformCreateFunc,
          creationParams: 'ios-key',
          creationParamsCodec: StandardMessageCodec());
    } else {
      return Text('有问题');
    }
  }

  void _onPlatformCreateFunc(int id) {
    print('_onPlatformCreateFunc--$id ');
  }
}
