import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

/**
 * SINGLETON
 */
class User {
  String _uuid = "";
  String _token = "";

  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  set setToken(String token) {
    _token = token;
  }

  String get getToken {
    return _token;
  }

  set setUuid(String uuid) {
    _uuid = uuid;
  }

  String get getUuid {
    return _uuid;
  }

  Map<String, dynamic> toMap() {
    return {'uuid': getUuid, 'token': getToken};
  }

  User fromMap(Map<String, dynamic> map) {
    return User()
      ..setToken = map['token']
      ..setUuid = map['uuid'];
  }

  String toJson() => json.encode(toMap());

  User fromJson(String source) => fromMap(json.decode(source));

  void parseToken(String source) {
    setToken = json.decode(source);
  }

  void saveUser() async {
    var userDto = await Hive.openBox('user');
    userDto.put('active', User());
  }

  void deleteUser() async {
    var userDto = await Hive.openBox('user');
    userDto.delete('active');
  }

  Future<User> getSavedUser() async {
    var userDto = await Hive.openBox('user');
    User? user = userDto.get('active');
    if (user != null) {
      return User()
        ..setToken = user.getToken
        ..setUuid = user.getUuid;
    } else {
      return User();
    }
  }
}
