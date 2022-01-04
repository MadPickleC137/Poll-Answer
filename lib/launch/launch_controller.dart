import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/model/user.dart';

class LaunchController extends GetxController {
  var user = User().obs;
  Rx<Status> status = Status.Loading.obs;
  login() async {
    var savedUser = await user.value.getSavedUser();
    var response = await RestApi.login(uuid: savedUser.getUuid);
    if (response.status == Status.Success) {
      user.value = User();
      user.value.saveUser();
      getCategories();
    } else {
      status.value = response.status;
    }
  }

  getCategories() async {
    var response = await RestApi.getCategories();
    if (response.status == Status.Success) {
      var cache = await Hive.openBox('categories');
      cache.put('list', response.data);
      getUserQuistion();
    } else {
      status.value = response.status;
    }
  }

  getUserQuistion() async {}
}
