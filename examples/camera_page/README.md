### 介绍

摄像头例子中使用到了如下仓库
```
  #相机使用
  camera: ^0.5.2+1
  #路径
  path_provider: ^1.1.0
  #动态权限申请
  permission_handler: '^3.1.0'
  #视频播放
  video_player: ^0.10.1+3
```

### 权限申请

首先，权限申请需要在android和ios进行如下操作

#### android

在 android/app/src/main/AndroidManifest.xml 文件中添加用到的权限

```
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### 相机配置

#### android配置

在 android/app/build.gradle 文件中修改允许最低运行版本为：

```
    minSdkVersion 21
```

#### ios配置

在 ios/Runner/Info.plist 文件中添加两行代码

```
	<key>NSMicrophoneUsageDescription</key>
	<string>Can I use the mic please?</string>
	<key>NSCameraUsageDescription</key>
	<string>Can I use the camera please?</string>
```


### 视频播放器配置

#### android配置

如果需要用到网络视频播放，则需要在 android/app/main/AndroidManifest.xml 文件中添加以下权限

```
    <uses-permission android:name="android.permission.INTERNET"/>
```


#### ios配置

如果需要用到视频，在 ios/Runner/Info.plist 中添加如下内容

```
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```