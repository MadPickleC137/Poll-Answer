import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';

void showSnackbar(
    String title, String imagePath, Color imageColor, bool isError) {
  var message = messages[Random().nextInt(messages.length - 1)];
  Get.snackbar(title, isError ? '' : message,
      icon: Image.asset(
        imagePath,
        width: 22,
        height: 22,
        color: imageColor,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: textColorType2,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      boxShadows: snackBarShadow);
}
