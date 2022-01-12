import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/model/user.dart';
import 'package:poll_answer/navigation/routes.dart';

class LaunchController extends GetxController {
  var user = User().obs;
  int counterRequestLogin = 0;
  @override
  void onReady() {
    login();
  }

  login() async {
    counterRequestLogin++;
    try {
      var savedUser = await user.value.getSavedUser();
      var response = await RestApi.login(uuid: savedUser.getUuid);
      if (response.status == Status.Success) {
        user.value = User();
        user.value.saveUser();
        getCategories();
      } else {
        updateWithStatus(response.status);
      }
    } catch (ex) {
      printError(info: ex.toString());
      updateWithStatus(Status.Error);
    }
  }

  getCategories() async {
    try {
      var response = await RestApi.getCategories();
      if (response.status == Status.Success) {
        var cache = await Hive.openBox('categories');
        cache.put('list', response.data);
        getUserQuistion();
      } else {
        updateWithStatus(response.status);
      }
    } catch (ex) {
      printError(info: ex.toString());
      updateWithStatus(Status.Error);
    }
  }

  getUserQuistion() async {
    var response = await RestApi.getUserQuestion();
    if (response.status == Status.Success) {
      var cache = await Hive.openBox('user-questions');
      cache.put('list', response.data);
    }
    updateWithStatus(response.status);
  }

  updateWithStatus(Status value) async {
    switch (value) {
      case Status.Empty:
      case Status.Unauthorized:
        if (counterRequestLogin < 2) {
          login();
        }
        break;
      case Status.Success:
        Get.offNamed(Routes.MAIN);
        break;
      case Status.Error:
      case Status.Forbidden:
        Get.offNamed(Routes.QUIZ_CREATE);
        break;
      default:
        break;
    }
  }
}
