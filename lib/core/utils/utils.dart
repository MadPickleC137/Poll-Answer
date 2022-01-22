import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

bool isActiveDarkTheme() {
  var brightness = SchedulerBinding.instance?.window.platformBrightness;
  return brightness == Brightness.dark;
}

bool isDebugMode() {
  if (kReleaseMode) {
    return false;
  } else {
    return true;
  }
}

Future<File> parseImage(String base64Image) async {
  var decodedImage = base64.decode(base64Image);
  File fileImage = File.fromRawPath(decodedImage);
  return fileImage;
}
