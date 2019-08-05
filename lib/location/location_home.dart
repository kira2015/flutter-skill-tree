import 'package:amap_location/amap_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              SizedBox(height: 200,),
              Row(children: <Widget>[
                Text(
                '详细地址:  ',
              ),
                Text(
                '$_locationStr',
              ),
              ],),
              Row(children: <Widget>[
                Text(
                '温馨提示:  ',
                style: TextStyle(color: Colors.green,)
              ),
                Text(
                '$_locationTipStr',
              ),
              ],),
              Row(children: <Widget>[
                Text(
                '标志建筑:  ',
                style: TextStyle(color: Colors.red,)
              ),
                Text(
                '$_locationPStr',
              ),
              ],),
              
  
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
    AMapLocation location = await AMapLocationClient.getLocation(true);

     _locationStr = '${location.country}${location.province}${location.city}${location.street}${location.number}';
    _locationTipStr = '${location.formattedAddress}';
    _locationPStr = '${location.POIName}';
    setState(() {
    });
  }
}
