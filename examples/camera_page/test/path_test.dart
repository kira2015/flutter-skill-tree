import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main(){



  test("\n测试文件路径\n", (){
    Directory directory = Directory.current;
    print("当前目录:${directory.path}");
    final list = directory.listSync();
    for (var o in list) {
      final filename = o.path.split("/").last;

      print("path:${o.path}   name:${filename}");
    }
  });


}