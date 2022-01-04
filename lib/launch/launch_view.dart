import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_answer/launch/launch_controller.dart';

class LaunchView extends StatelessWidget {
  final _controller = Get.put(LaunchController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (controller) {
      return Scaffold(
        body: Container(),
      );
    });
  }
}
