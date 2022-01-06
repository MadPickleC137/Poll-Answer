// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:poll_answer/launch/launch_controller.dart';

class LaunchView extends StatelessWidget {
  final _controller = Get.put(LaunchController());

  final textStyle = TextStyle(
    fontFamily: 'rubik',
    fontSize: 48,
    color: Colors.white,
    letterSpacing: 1.4,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF43CEA2),
            Color(0xFF185A9D),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: Localizations.localeOf(context).toString() == "ru"
                    ? ruTitle
                    : enTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: FadeIn(
                  child: Lottie.asset(
                'assets/anim/loader.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              )),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get ruTitle {
    return [
      Text(
        "B",
        style: textStyle,
      ),
      FadeIn(
        child: Image.asset(
          'assets/img/ic_map.png',
          width: 50,
          height: 50,
        ),
      ),
      Text(
        "ПРОС",
        style: textStyle,
      ),
    ];
  }

  List<Widget> get enTitle {
    return [
      FadeIn(
        child: Image.asset(
          'assets/img/ic_map_en.png',
          width: 50,
          height: 50,
        ),
      ),
      Text(
        "UESTION",
        style: textStyle,
      ),
    ];
  }
}
