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
