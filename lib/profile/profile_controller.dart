import 'package:get/get.dart';

class ProfileController extends GetxController {
  int groupValue = 0;

  void onChangeSegment(int? value) {
    if (value != null) {
      groupValue = value;
      update();
    }
  }
}
