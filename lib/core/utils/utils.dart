import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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

Future<Uint8List> parseImage(String? base64Image) async {
  if (base64Image != null) {
    var decodedImage = base64.decode(base64Image);
    return decodedImage;
  } else {
    return Uint8List(0);
  }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

double getScreenHeight(BuildContext ctx) {
  return MediaQuery.of(ctx).size.height;
}

double getScreenWidth(BuildContext ctx) {
  return MediaQuery.of(ctx).size.width;
}
