import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  // ignore: non_constant_identifier_names
  final url_login = "https://chocaycanh.club/public/api/login";
  late Dio _dio;
  ApiService() {
    _dio = Dio(BaseOptions(responseType: ResponseType.json));
  }

  Future<Response?> loginUser(String username, String password) async {
    Map<dynamic, dynamic> param = {
      "username": username,
      "password": password,
      "device_name": "android"
    };
    Map<String, String> headers = {
      'Content-Type': "application/json; charset=UTF-8",
    };
    try {
      final response = await _dio.post(url_login,
      data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }
}
