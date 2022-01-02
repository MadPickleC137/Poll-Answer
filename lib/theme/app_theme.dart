import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poll_answer/theme/colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData();
}

const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: systemNavigationBarColor);
