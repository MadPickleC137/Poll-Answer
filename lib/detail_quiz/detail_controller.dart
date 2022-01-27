import 'package:get/get.dart';

class DetailController extends GetxController {
  RxBool collapsed = true.obs;
  void navigateToBack() {
    Get.back();
  }
}
