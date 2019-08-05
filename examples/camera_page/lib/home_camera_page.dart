import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera_page/pages/camera_page.dart';

class HomeCameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("与本地交互"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: () async {

              List<CameraDescription> cameras = await availableCameras();
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
                return CameraPage(cameras);
              }));
            },
            child: Text(
              "开启相机",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            )),
      ),
    );
  }
}
