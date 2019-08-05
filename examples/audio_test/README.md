## 录音的使用

主要使用的仓库如下

```
  #录音控件
  flutter_sound: ^1.4.2
  #路径获取
  path_provider: ^1.1.2
  #动态权限申请
  permission_handler: '^3.1.0'
```

由于需要用到录音、存储权限，所以要进行如下配置

### Android端权限配置

在 android/app/src/main/AndroidManifest.xml 中添加如下内容：

```
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### Ios端权限配置

在 ios/runner/info.plist 中添加：

```
    <key>NSMicrophoneUsageDescription</key>
    <string>语音权限申请.</string>
    <key>UIBackgroundModes</key>
    <array>
    	<string>audio</string>
    </array>
```