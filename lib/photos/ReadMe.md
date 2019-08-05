import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



###核心代码
<!-- 照片 -->
ImagePicker.pickImage(source: ImageSource.gallery);
<!-- 摄像头拍照 -->
ImagePicker.pickImage(source: ImageSource.camera);
<!-- 视频 -->
ImagePicker.pickVideo();
<!-- 检索丢失的数据 -->
ImagePicker.retrieveLostData();


#！！记得先开权限！！#