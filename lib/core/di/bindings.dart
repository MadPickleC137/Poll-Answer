import 'package:get/instance_manager.dart';
import 'package:poll_answer/create_quiz/quiz_create_controller.dart';
import 'package:poll_answer/disconnect/disconnect_controller.dart';
import 'package:poll_answer/launch/launch_controller.dart';
import 'package:poll_answer/navigation/navigation_controller.dart';
import 'package:poll_answer/search/search_controller.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NavigationController>(NavigationController());
    Get.put<LaunchController>(LaunchController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<DiconnectController>(() => DiconnectController());
    Get.lazyPut<CreateController>(() => CreateController());
  }
}
