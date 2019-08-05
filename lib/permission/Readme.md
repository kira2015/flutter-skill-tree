## PermissionTest

这个测试主要是关于动态权限申请的使用

所用插件库为：
```
  #权限申请
  permission_handler: '^3.1.0'
```

## 相关配置

### Android端配置

在调用权限申请的时候，还需要在配置文件中加入权限的声明

android中所有的权限声明全放在 android/app/main/AndroidManifest.xml 文件中

#### 日历读取权限

PermissionGroup.calendar

```
    <uses-permission android:name="android.permission.READ_CALENDAR" />
```

#### 相机权限

PermissionGroup.camera

```
    <uses-permission android:name="android.permission.CAMERA" />
```

#### 联系人读取权限

PermissionGroup.contacts

```
    <uses-permission android:name="android.permission.READ_CONTACTS" />
```

#### 定位权限

PermissionGroup.location

在android中 PermissionGroup.location、PermissionGroup.locationAlways、PermissionGroup.locationWhenInUse调用其中一个即可

```
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_LOCATION_EXTRA_COMMANDS" />
```

#### 媒体库权限

PermissionGroup.mediaLibrary

android中没有

#### 录音权限

PermissionGroup.microphone

```
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
```

#### 电话权限

PermissionGroup.phone

android中才有

```
    <uses-permission android:name="android.permission.CALL_PHONE" />
```

#### 照片读取权限

PermissionGroup.photos

ios中才有


#### 提醒权限

PermissionGroup.reminders

ios中才有

#### 传感器权限

PermissionGroup.sensors

```
    <uses-permission android:name="android.permission.BODY_SENSORS" />
```


#### 短信读取权限

PermissionGroup.sms

```
    <uses-permission android:name="android.permission.READ_SMS" />
```

#### 存储权限

PermissionGroup.storage

```
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

<key>NSPhotoLibraryUsageDescription</key>
<string>App需要您的同意,才能访问相册</string>
<key>NSCameraUsageDescription</key>
<string>App需要您的同意,才能访问相机</string>
<key>NSMicrophoneUsageDescription</key>
<string>App需要您的同意,才能访问麦克风</string>
<key>NSLocationUsageDescription</key>
<string>App需要您的同意,才能访问位置</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>App需要您的同意,才能在使用期间访问位置</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>App需要您的同意,才能始终访问位置</string>
<key>NSCalendarsUsageDescription</key>
<string>App需要您的同意,才能访问日历</string>
<key>NSRemindersUsageDescription</key>
<string>App需要您的同意,才能访问提醒事项</string>
<key>NSMotionUsageDescription</key>
<string>App需要您的同意,才能访问运动与健身</string>
<key>NSHealthUpdateUsageDescription</key>
<string>App需要您的同意,才能访问健康更新 </string>
<key>NSHealthShareUsageDescription</key>
<string>App需要您的同意,才能访问健康分享</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>App需要您的同意,才能访问蓝牙</string>
<key>NSAppleMusicUsageDescription</key>
<string>App需要您的同意,才能访问媒体资料库</string>
