import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHomePage extends StatelessWidget {
  final List<PermissionInfo> permissionList = [
    PermissionInfo("日历", PermissionGroup.calendar, Icons.calendar_today),
    PermissionInfo("相机", PermissionGroup.camera, Icons.camera_alt),
    PermissionInfo("联系人", PermissionGroup.contacts, Icons.contacts),
    PermissionInfo("定位", PermissionGroup.location, Icons.location_on),
    //ios
    PermissionInfo(
        "永久定位权限", PermissionGroup.locationAlways, Icons.add_location),
    //ios
    PermissionInfo(
        "使用时定位", PermissionGroup.locationWhenInUse, Icons.not_listed_location),
    //ios
    PermissionInfo("媒体库", PermissionGroup.mediaLibrary, Icons.library_music),
    PermissionInfo("录音", PermissionGroup.microphone, Icons.mic),
    //android
    PermissionInfo("电话", PermissionGroup.phone, Icons.phone),
    //ios
    PermissionInfo("照片", PermissionGroup.photos, Icons.photo),
    //ios
    PermissionInfo("提醒", PermissionGroup.reminders, Icons.notifications_active),
    PermissionInfo("传感器", PermissionGroup.sensors, Icons.device_hub),
    //android
    PermissionInfo("短信", PermissionGroup.sms, Icons.sms),
    PermissionInfo("说话", PermissionGroup.speech, Icons.speaker_phone),
    PermissionInfo("存储", PermissionGroup.storage, Icons.sd_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("权限申请"),
      ),
      body: Container(
        child: ListView(
            children: List.generate(permissionList.length, (index) {
          final permissionName = permissionList[index].permissionName;
          final permissionIcon = permissionList[index].permissionIcon;
          final permissionType = permissionList[index].permissionType;
          final iconColor = permissionList[index].iconColor;
          return ListTile(
            leading: Icon(
              permissionIcon,
              color: iconColor,
            ),
            title: Text(permissionName),
            onTap: () async {
              debugPrint("权限  ${permissionType}");

              Map<PermissionGroup, PermissionStatus> permissions =
                  await PermissionHandler()
                      .requestPermissions([permissionType]);

              if (permissions[permissionType] == PermissionStatus.granted) {
                debugPrint("权限  ${permissionType}  同意");
                popDialog(context, permissionName, "权限申请成功");
              } else if (permissions[permissionType] ==
                  PermissionStatus.denied) {
                debugPrint("权限  ${permissionType}  拒绝");
                popDialog(
                  context,
                  permissionName,
                  "权限被拒绝",
                  showOpenSettingButton: true,
                );
              } else if (permissions[permissionType] ==
                  PermissionStatus.disabled) {
                debugPrint("权限  ${permissionType}  不可用");
                popDialog(context, permissionName, "权限不可用");
              } else if (permissions[permissionType] ==
                  PermissionStatus.restricted) {
                //只在ios上
                debugPrint("权限  ${permissionType}  被限制");
                popDialog(context, permissionName, "权限被限制");
              } else if (permissions[permissionType] ==
                  PermissionStatus.unknown) {
                debugPrint("权限  ${permissionType}  未知");
                popDialog(context, permissionName, "权限未知");
              }
            },
          );
        })),
      ),
    );
  }

  void popDialog(
      BuildContext context, String permissionName, String description,
      {bool showOpenSettingButton = false}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("${permissionName}${description}"),
            actions: <Widget>[
              showOpenSettingButton
                  ? FlatButton(onPressed: () {
                    PermissionHandler().openAppSettings();
              }, child: Text("打开设置页面"))
                  : SizedBox(),
            ],
          );
        });
  }

  Widget getIcon() {}
}

class PermissionInfo {
  String permissionName;
  PermissionGroup permissionType;
  IconData permissionIcon;
  Color iconColor;

  PermissionInfo(
      this.permissionName, this.permissionType, this.permissionIcon) {
    this.iconColor = _getRandomColor();
  }

  Color _getRandomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}
