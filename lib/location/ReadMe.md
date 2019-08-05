### 高德地图
  amap_location: ^0.2.0

#1、申请一个key http://lbs.amap.com/api/ios-sdk/guide/create-project/get-key
、、、
    void main(){     
        AMapLocationClient.setApiKey("你的key");
        runApp(new MyApp());
    }
、、、

#2、权限申请
ios:
、、、
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>要用定位</string>
    另外开启BackgroundModes -> Location updates
、、、
安卓
#项目目录/app/build.gradle 在android/defaultConfig节点修改manifestPlaceholders,新增高德地图key配置
、、、
 android {
    .... 你的代码

    defaultConfig {
        .....
        manifestPlaceholders = [
                AMAP_KEY : "aa9f0cf8574400f2af0078392c556e25", /// 高德地图key
        ]

    }

    ...你的代码

    dependencies {
        /// 注意这里需要在主项目增加一条依赖，否则可能发生编译不通过的情况
        implementation 'com.amap.api:location:latest.integration'
        ...你的代码
    }
、、、
#3、启动
、、、
    await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
、、、

#4、 获取定位
、、、
    await AMapLocationClient.getLocation(true);
、、、

#5、实现监听
、、、
    AMapLocationClient.onLocationUpate.listen((AMapLocation loc){
      if(!mounted)return;
      setState(() {
         ...
      });
    });

    AMapLocationClient.startLocation();
、、、
///停止监听  AMapLocationClient.stopLocation();

#6、关闭定位
 AMapLocationClient.shutdown();


##注意##  在android6以上最好手动获取定位权限
#eg:
    void _checkPersmission() async{
        bool hasPermission = await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
        if(!hasPermission){
        bool requestPermissionResult = await SimplePermissions.requestPermission(Permission.WhenInUseLocation);
        if(!requestPermissionResult){
            Alert.alert(context,title: "申请定位权限失败");
            return;
        }
        }
        AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
        if (!mounted) return;
        setState(() {
            location = getLocationStr(loc);
        });
        });

        AMapLocationClient.startLocation();
    }