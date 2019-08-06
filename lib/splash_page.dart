import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      child: FlareActor(
        "flrs/splash_anim.flr",
        fit: BoxFit.scaleDown,
        animation: "splash",
        callback: (anim) {
          print("结束");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) {
                return MyHomePage();
              }), (router) => false);
        },
      ),
    );
  }
}
