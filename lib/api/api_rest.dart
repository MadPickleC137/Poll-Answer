import 'dart:convert';

import 'package:poll_answer/api/api_router.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/model/user.dart';
import 'package:http/http.dart' as http;

class RestApi {
  static Future<Map<String, String>> get _header async {
    User user = User();
    return {
      'Authorization': 'Bearer ${user.getToken}',
      'Content-Type': 'application/json',
    };
  }

  static Uri _url(String path, Map<String, dynamic> params) {
    String url = RouterApi.rootUrl + path;
    params.forEach((key, value) {
      if (params.keys.first == key) {
        url = "$url?$key=$value";
      } else {
        url = "$url&$key=$value";
      }
    });
    return Uri.parse(url);
  }

  static Future<ResponseApi<User>> login({String uuid = ""}) async {
    Uri url = _url(RouterApi.loginUrl, uuid.isNotEmpty ? {'guid': uuid} : {});
    var response = await http.post(url);
    Status status = Status.Empty;
    User data = User();
    if (response.statusCode == 200) {
      data = User().fromJson(response.body);
    }
    status = _checkAnyStatus(response.statusCode);
    return ResponseApi<User>(status: status, data: data);
  }

  static Future<ResponseApi<List<Category>>> getCategories() async {
    var response = await http.get(_url(RouterApi.getCategoriesUrl, {}),
        headers: await _header);
    Status status = Status.Empty;
    List<Category> data = [];
    if (response.statusCode == 200) {
      List<dynamic> array = json.decode(response.body);
      for (var item in array) {
        data.add(Category.fromMap(item));
      }
    }
    status = _checkAnyStatus(response.statusCode);
    return ResponseApi(status: status, data: data);
  }

  static Future<ResponseApi<List<Question>>> getUserQuestions() async {
    Uri url = _url(RouterApi.getUserQuestions, {});
    var response = await http.get(url, headers: await _header);
    Status status = Status.Empty;
    List<Question> data = [];
    if (response.statusCode == 200) {
      List<dynamic> array = json.decode(response.body);
      for (var item in array) {
        data.add(Question.fromMap(item));
      }
    }
    status = _checkAnyStatus(response.statusCode);
    return ResponseApi(status: status, data: data);
  }

  static Future<ResponseApi> createQuestion(Question question) async {
    Uri url = _url(RouterApi.addQuestionUrl, {});
    var body = question.toJsonForSend();
    print(body);
    var response = await http.post(url, headers: await _header, body: body);
    Status status = Status.Empty;
    print(response.body);
    status = _checkAnyStatus(response.statusCode);

    return ResponseApi(status: status, data: null);
  }

  static Future<ResponseApi<List<Question>>> getBundleQuestions(
      int count, int? lastIndex, int? categoryId) async {
    Map<String, dynamic> query = {
      "recordCount": count,
      "lastRecord": lastIndex ?? "",
      "category": categoryId ?? "",
    };
    Uri url = _url(RouterApi.getBundleQuestions, query);
    var response = await http.get(url, headers: await _header);
    Status status = Status.Empty;
    List<Question> data = [];
    if (response.statusCode == 200) {
      List<dynamic> array = json.decode(response.body);
      for (var item in array) {
        data.add(Question.fromMap(item));
      }
    }
    status = _checkAnyStatus(response.statusCode);
    return ResponseApi(status: status, data: data);
  }

  static Future<ResponseApi> voteByQuestion(
      int questionId, int answerId) async {
    Map<String, dynamic> query = {
      "questionId": questionId,
      "answerId": answerId,
    };
    Uri url = _url(RouterApi.putVote, query);
    var response = await http.put(url, headers: await _header);
    Status status = _checkAnyStatus(response.statusCode);
    return ResponseApi(status: status, data: null);
  }

  static Status _checkAnyStatus(int statusCode) {
    var status = Status.Empty;
    switch (statusCode) {
      case 200:
      case 204:
        status = Status.Success;
        break;
      case 400:
        status = Status.Error;
        break;
      case 401:
        status = Status.Unauthorized;
        break;
      case 403:
        status = Status.Forbidden;
        break;
      default:
        status = Status.Error;
        break;
    }
    return status;
  }
}
