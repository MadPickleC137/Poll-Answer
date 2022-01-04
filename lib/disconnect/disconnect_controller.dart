import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DiconnectController extends GetxController {
  closeApplication() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
