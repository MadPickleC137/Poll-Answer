// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/disconnect/disconnect_controller.dart';
import 'package:poll_answer/theme/colors.dart';

class DisconnectView extends StatelessWidget {
  final controller = Get.put(DiconnectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            gradientStartType2,
            gradientEndType2,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Image.asset(
                'assets/img/no_connect.png',
                width: 200,
                height: 200,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Text(
                tr('disconnect_description'),
                style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 16,
                    wordSpacing: 2.4,
                    letterSpacing: 1.0,
                    color: diconnectTextColor),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: buttonHeight,
              margin: const EdgeInsets.only(top: 80.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: gradientStartType1,
                        offset: Offset(0, 0),
                        blurRadius: 15.0),
                  ],
                  gradient: LinearGradient(colors: [
                    gradientStartType1,
                    gradientEndType1,
                  ]),
                  borderRadius: BorderRadius.circular(buttonBorderRadius)),
              child: TextButton(
                  onPressed: () {
                    controller.closeApplication();
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(gradientStartType1),
                    minimumSize:
                        MaterialStateProperty.all(Size(150, buttonHeight)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonBorderRadius),
                      ),
                    ),
                  ),
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 14,
                      color: diconnectTextColor,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
