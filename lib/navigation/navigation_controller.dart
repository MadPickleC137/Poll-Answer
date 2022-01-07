import 'package:get/get.dart';
import 'package:poll_answer/navigation/routes.dart';

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
    if (value == 1) {
      Get.toNamed(Routes.QUIZ_CREATE);
    } else {
      screenIndex.value = value;
      update();
    }
  }
}
