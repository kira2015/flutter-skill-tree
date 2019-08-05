import 'package:flutter/material.dart';
import 'package:camera_page/widget/my_video_player.dart';

class VideoPage extends StatelessWidget {

  final String videoPath;
  final int index;

  const VideoPage({Key key, this.videoPath, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("录像:${index}"),),
      body: MyVideoPlayer(videoPath: videoPath,),
    );
  }
}
