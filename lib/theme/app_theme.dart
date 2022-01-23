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

const List<BoxShadow> questionBodyShadow = [
  BoxShadow(
    color: bottomNavBarColor,
    offset: Offset(4, 4),
    blurRadius: 30,
    spreadRadius: 0.5,
  ),
  BoxShadow(
    color: bottomNavBarColor,
    offset: Offset(-4, -4),
    blurRadius: 30,
    spreadRadius: 0.5,
  ),
];

const TextStyle titleTextStyle = TextStyle(
    fontFamily: 'rubik',
    letterSpacing: 1.0,
    fontSize: 16,
    color: textColorType3);

const TextStyle messageTextStyle = TextStyle(
    fontFamily: 'rubik',
    fontSize: 14,
    wordSpacing: 2.4,
    letterSpacing: 1.0,
    color: textColorType3);

const TextStyle normalTextStyle = TextStyle(
  fontFamily: 'rubik',
  fontSize: 14,
  color: textColorType4,
);
