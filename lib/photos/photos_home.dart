import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotosHome extends StatefulWidget {
  @override
  _PhotosHomeState createState() => _PhotosHomeState();
}

class _PhotosHomeState extends State<PhotosHome> {
  File _image;
  //来源：相册gallery or 摄像头camera
  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('读取资源库'),
        ),
        body: Center(
          child: _image == null ? Text('请选择展示的图片') : Image.file(_image),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (int index) {
            return index == 0
                ? getImage(ImageSource.camera)
                : getImage(ImageSource.gallery);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo), title: Text('相机')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_photo_alternate), title: Text('相册')),
          ],
        ));
  }
}
