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
      status = Status.Success;
      data = User().fromJson(response.body);
    } else {
      status = Status.Error;
    }
    if (response.statusCode == 403) {
      status = Status.Forbidden;
    }
    return ResponseApi<User>(status: status, data: data);
  }

  static Future<ResponseApi<List<Category>>> getCategories() async {
    var response = await http.get(_url(RouterApi.getCategoriesUrl, {}),
        headers: await _header);
    Status status = Status.Empty;
    List<Category> data = [];
    if (response.statusCode == 200) {
      status = Status.Success;
      List<dynamic> array = json.decode(response.body);
      for (var item in array) {
        data.add(Category.fromMap(item));
      }
    } else if (response.statusCode == 401) {
      status = Status.Unauthorized;
    } else {
      status = Status.Error;
    }
    return ResponseApi(status: status, data: data);
  }

  static Future<ResponseApi<List<Question>>> getUserQuestion() async {
    Uri url = _url(RouterApi.getUserQuestions, {});
    var response = await http.get(url, headers: await _header);
    Status status = Status.Empty;
    List<Question> data = [];
    if (response.statusCode == 200) {
      status = Status.Success;
      List<dynamic> array = json.decode(response.body);
      for (var item in array) {
        data.add(Question.fromMap(item));
      }
    } else if (response.statusCode == 401) {
      status = Status.Unauthorized;
    } else {
      status = Status.Error;
    }
    return ResponseApi(status: status, data: data);
  }

  static Future<ResponseApi> createQuestion(Question question) async {
    Uri url = _url(RouterApi.addQuestionUrl, {});
    var body = question.toJsonForSend();
    print(body);
    var response = await http.post(url, headers: await _header, body: body);
    Status status = Status.Empty;
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 204) {
      status = Status.Success;
    } else if (response.statusCode == 401) {
      status = Status.Unauthorized;
    } else {
      status = Status.Error;
    }
    return ResponseApi(status: status, data: null);
  }
}
