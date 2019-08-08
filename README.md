![001](https://user-images.githubusercontent.com/30992818/62670442-d2edb380-b9c5-11e9-83b3-d40b6f2bbff9.png)

超适合学习的Flutter项目！

# 前言

**面向所有对Flutter与原生交互知之甚少的开发者们**

- 如果你是对Ios与Android不够了解的前端开发者
- 如果你是对Android不够了解的Ios开发者
- 如果你是对Ios不够了解的Android开发者

这个项目，都将会是你最好的学习材料

> 目前项目包含的主要内容是各种需要与原生交互的插件使用。后续会继续完善此类Demo，同时也会插入一些纯Dart实现的Demo


# 项目介绍

## 功能点

目前，项目包含的功能点如下


<img width="200" height="422" src="https://user-images.githubusercontent.com/30992818/62671773-b7d17280-b9ca-11e9-9b46-d14fe0be798c.png"/>


下面是各个功能点，其中，部分功能无法在Ios模拟器上正常使用，如**视频播放**功能与**定位**功能

功能点列表 | 展示  | 使用插件 
---|---|---
[相机](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/camera_page) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673676-de46dc00-b9d1-11e9-94b4-4c6f79af974f.png"/> | [camera](https://pub.dev/packages/camera) 
[权限申请](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/permission_test) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673480-2f0a0500-b9d1-11e9-80ae-292b48e48538.png"/> | [permission_handler](https://pub.dev/packages/permission_handler) 
数据存储 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673481-2f0a0500-b9d1-11e9-8714-f29329bd86b4.png"/> | [path_provider](https://pub.dev/packages/path_provider) + File操作 
相册 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673482-2fa29b80-b9d1-11e9-86a9-1a8bdd06dd5d.png"/> | [image_picker](https://pub.dev/packages/image_picker) 
[录音](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/audio_test) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673484-2fa29b80-b9d1-11e9-85f7-885bf341f838.png"/> | [flutter_sound](https://pub.dev/packages/flutter_sound) 
定位 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673485-2fa29b80-b9d1-11e9-9ac2-2029fa707f89.png"/> | [amap_location](https://pub.dev/packages/amap_location) 
下载 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673488-303b3200-b9d1-11e9-8c19-340e298b0077.png"/> | [flutter_downloader](https://pub.dev/packages/flutter_downloader) 
[分享](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/share_test) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673496-316c5f00-b9d1-11e9-86f2-0d2d6b826ac4.png"/> | [share](https://pub.dev/packages/share) 
[图片裁剪](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/crop_test) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673499-3204f580-b9d1-11e9-9b2b-957c5dfdd491.png"/> | [image_crop](https://pub.dev/packages/image_crop) 
视频播放 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673503-33362280-b9d1-11e9-8528-6d76b966f232.png"/> | [chewie](https://pub.dev/packages/chewie) 
二维码 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673489-30d3c880-b9d1-11e9-80f9-8d0c14b5f8ce.png"/> | [flutter_barcode_scanner](https://pub.dev/packages/flutter_barcode_scanner) 和 [qr_flutter](https://pub.dev/packages/qr_flutter)  
自适应文本 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673486-303b3200-b9d1-11e9-9e9e-c9ee97ac6160.png"/> | [auto_size_text](https://pub.dev/packages/auto_size_text) 
拖拽控件 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673487-303b3200-b9d1-11e9-929c-c69a70c12769.png"/> | 手势操作 
[天气动画](https://github.com/kira2015/flutter-skill-tree/tree/master/examples/animation_test) | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673492-30d3c880-b9d1-11e9-9102-9c4a6ea266f4.png"/> | Animation与Widget组合 
拖拽列表 | <img width="100" height="200" src="https://user-images.githubusercontent.com/30992818/62673500-329d8c00-b9d1-11e9-9732-99e2d58e5d5b.png"/> | ReorderableListView的使用


## 目录结构

项目目录结构如下

![image](https://user-images.githubusercontent.com/30992818/62680063-ececbd80-b9e8-11e9-95c7-4bc797c24fde.png)

我们将单个的例子都放在了 <code>**examples**</code> 目录下，如果只对其中某个功能点感兴趣，可以直接进入相关目录，在每个功能点目录下都有相关readme对该功能进行介绍，比如使用配置等。

而同时这个项目本身整合了所有的单个例子，可以直接运行测试。


## 最后

欢迎在issue中提出想要新增的功能点，或者其他好的意见与建议。

👏👏如果项目对你有所帮助，也非常欢迎前来Star🌟🌟🌟🌟！


## Todo

- 支付模块
- IM模块
- 推送模块