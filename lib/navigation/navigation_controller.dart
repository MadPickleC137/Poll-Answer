import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt screenIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChangeScreen(int value) {
    screenIndex.value = value;
    update();
  }
}
