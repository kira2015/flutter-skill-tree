import 'package:amap_location/amap_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHome extends StatefulWidget {
  @override
  _LocationHomeState createState() => _LocationHomeState();
}

class _LocationHomeState extends State<LocationHome> {
  String _locationStr = '';
  String _locationTipStr = '';
  String _locationPStr = '';

  @override
  void initState() {
    setupLocation();

    super.initState();
  }

  @override
  void dispose() {
    //注意这里关闭
    AMapLocationClient.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('定位'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              CupertinoButton(
                child: Text('获取定位'),
                onPressed: () {
                  getLocationDesc();
                },
              ),
              SizedBox(
                height: 200,
              ),
              Row(
                children: <Widget>[
                  Text(
                    '详细地址:  ',
                  ),
                  Text(
                    '$_locationStr',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('温馨提示:  ',
                      style: TextStyle(
                        color: Colors.green,
                      )),
                  Text(
                    '$_locationTipStr',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('标志建筑:  ',
                      style: TextStyle(
                        color: Colors.red,
                      )),
                  Text(
                    '$_locationPStr',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setupLocation() async {
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
  }

  void getLocationDesc() async {
    
        Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      print('权限申请成功');

      AMapLocation location = await AMapLocationClient.getLocation(true);
      _locationStr =
          '${location.country}${location.province}${location.city}${location.street}${location.number}';
      _locationTipStr = '${location.formattedAddress}';
      _locationPStr = '${location.POIName}';
      setState(() {});
    } else {
      popDialog(context, '需要用到手机的定位权限', '请设置允许', showOpenSettingButton: true);
    }
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
