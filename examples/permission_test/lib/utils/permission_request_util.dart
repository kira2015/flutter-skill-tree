import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionReqUtil {
  static PermissionReqUtil _instance;

  static PermissionReqUtil getInstance() {
    if (_instance == null) {
      _instance = PermissionReqUtil._internal();
    }
    return _instance;
  }

  PermissionReqUtil._internal();

  void requestPermission(
    PermissionGroup reqPermissions, {
    bool showDialog = true,
    BuildContext context,
    VoidCallback granted,
    VoidCallback denied,
    VoidCallback disabled,
    VoidCallback restricted,
    VoidCallback unknown,
  }) async {
    Map<PermissionGroup, PermissionStatus> output =
        await PermissionHandler().requestPermissions([reqPermissions]);

    switch (output[reqPermissions]) {
      case PermissionStatus.granted:
        if (granted != null) granted();
        toShow(showDialog, context, reqPermissions, "权限申请成功");
        break;
      case PermissionStatus.denied:
        if (denied != null) denied();
        toShow(
          showDialog,
          context,
          reqPermissions,
          "权限被拒绝",
          showOpenSettingButton: true,
        );
        break;
      case PermissionStatus.disabled:
        if (disabled != null) disabled();
        toShow(showDialog, context, reqPermissions, "权限不可用");
        break;
      case PermissionStatus.restricted:
        if (restricted != null) restricted();
        toShow(showDialog, context, reqPermissions, "权限被限制",
            showOpenSettingButton: true);
        break;
      case PermissionStatus.unknown:
        if (unknown != null) unknown();
        toShow(showDialog, context, reqPermissions, "没有这个权限");
        break;
    }
  }

  void toShow(bool showDialog, BuildContext context,
      PermissionGroup reqPermissions, String description,
      {bool showOpenSettingButton = false}) {
    if (showDialog) {
      if (context == null)
        throw FlutterError("\n\nshowOpenSettingButton为true的时候context不能为空\n");
      toShowDialog(
        context,
        "${reqPermissions}",
        description,
        showOpenSettingButton: showOpenSettingButton,
      );
    }
  }

  void toShowDialog(
      BuildContext context, String permissionName, String description,
      {bool showOpenSettingButton = false}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("${permissionName}${description}"),
            actions: <Widget>[
              showOpenSettingButton
                  ? FlatButton(
                      onPressed: () {
                        PermissionHandler().openAppSettings();
                      },
                      child: Text("打开设置页面"))
                  : SizedBox(),
            ],
          );
        });
  }
}
