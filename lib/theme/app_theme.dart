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

const List<BoxShadow> buttonShadowType1 = [
  BoxShadow(
    color: Color(0x441FA5FF),
    offset: Offset(2, 2),
    blurRadius: 30,
    spreadRadius: 0.5,
  ),
  BoxShadow(
    color: Color(0x5D1FA5FF),
    offset: Offset(-4, -4),
    blurRadius: 30,
    spreadRadius: 0.5,
  ),
];
