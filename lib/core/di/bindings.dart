import 'package:get/instance_manager.dart';
import 'package:poll_answer/disconnect/disconnect_controller.dart';
import 'package:poll_answer/navigation/navigation_controller.dart';
import 'package:poll_answer/search/search_controller.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NavigationController>(NavigationController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<DiconnectController>(() => DiconnectController());
  }
}
