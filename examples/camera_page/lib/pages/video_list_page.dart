import 'package:flutter/material.dart';
import 'package:camera_page/pages/video_page.dart';
import 'package:camera_page/widget/my_video_player.dart';
// import 'package:video_player/video_player.dart';

class VideoListPage extends StatefulWidget {

  final List<String> videoPaths;


  VideoListPage(this.videoPaths);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("录像"),),
      body: Container(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(widget.videoPaths.length, (index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: 150,
                height: 150,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                      return VideoPage(videoPath: widget.videoPaths[index],index: index,);
                    }));
                  },
                  child: MyVideoPlayer(videoPath: widget.videoPaths[index],),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
