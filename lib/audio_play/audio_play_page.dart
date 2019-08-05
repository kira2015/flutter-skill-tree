import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayPage extends StatefulWidget {

  final String path;

  const AudioPlayPage({Key key, this.path}) : super(key: key);



  @override
  _AudioPlayPageState createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  bool isPlaying = false;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

  String playerText = '00:00:00';

  double slider_current_position = 0.0;
  double max_duration = 1.0;


  @override
  void initState() {
    super.initState();
    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
  }


  @override
  void dispose() {
    _playerSubscription?.cancel();
    super.dispose();
  }

  String transformData(DateTime date){
    int mSecond = (date.millisecond / 10).toInt();
    int second = date.second;
    int minute = date.minute;
    int hour = date.hour;
    String theHour = hour < 10 ? "0${hour}" : "${hour}";
    String theMinute = minute < 10 ? "0${minute}" : "${minute}";
    String theSecond = second < 10 ? "0${second}" : "${second}";
    String themSecond = mSecond < 10 ? "0${mSecond}" : "${mSecond}";
    return theMinute+":"+theSecond+":" +themSecond;
  }

  void startPlayer() async{
    if(isPlaying) {
      resumePlayer();
      return;
    };
    String path = await flutterSound.startPlayer(widget.path);
    await flutterSound.setVolume(1.0);

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((PlayStatus status) {
        if (status != null) {
          slider_current_position = status.currentPosition;
          max_duration = status.duration;
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              status.currentPosition.toInt(),
              isUtc: true);
          setState(() {
            this.isPlaying = true;
            this.playerText = transformData(date);
          });
          if(status.currentPosition == status.duration){
            setState(() {
              isPlaying = false;
              debugPrint("播放完成");
            });
          }
        }
      });
    } catch (err) {
      print('出错: $err');
    }
  }

  void stopPlayer() async{
    try {
      String result = await flutterSound.stopPlayer();
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this.isPlaying = false;
      });
    } catch (err) {
      print('停止出错: $err');
    }
  }

  void pausePlayer() async{
    if(!isPlaying) return;
    String result = await flutterSound.pausePlayer();
    setState(() {
      isPlaying = false;
    });
    print('暂停播放: $result    $isPlaying');
  }

  void resumePlayer() async{
    String result = await flutterSound.resumePlayer();
  }

  void seekToPlayer(int milliSecs) async{
    String result = await flutterSound.seekToPlayer(milliSecs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.path.split("/").last),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60.0, bottom:16.0),
                  child: Text(
                    this.playerText,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                        onPressed: () {
                          startPlayer();
                        },
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.play_arrow,color: Theme.of(context).primaryColor,)
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                        onPressed: () {
                          pausePlayer();
                        },
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.pause,color: Theme.of(context).primaryColor,)
                    ),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  child: ClipOval(
                    child: FlatButton(
                        onPressed: () {
                          stopPlayer();
                        },
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.stop, color: Theme.of(context).primaryColor,)
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Container(
                height: 56.0,
                child: Slider(
                    value: slider_current_position,
                    min: 0.0,
                    max: max_duration,
                    onChanged: (double value) async{
                      if(slider_current_position == max_duration) return;
                      await flutterSound.seekToPlayer(value.toInt());
                    },
                    divisions: max_duration.toInt()
                )
            )
          ],
        ),
    );
  }
}
