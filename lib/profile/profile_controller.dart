import 'package:get/get.dart';
import 'package:poll_answer/navigation/routes.dart';

class ProfileController extends GetxController {
  int groupValue = 0;

  void onChangeSegment(int? value) {
    if (value != null) {
      groupValue = value;
      update();
    }
  }

  void navigateToInfo() {
    Get.toNamed(Routes.INFO);
  }
}
