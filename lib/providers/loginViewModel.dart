// ignore_for_file: file_names

import 'package:connection/repositories/login_repositories.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0; // 0: not login, 1: waiting, 2:error, 3: already logged
  LoginRepository loginRepository = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepository.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Tên đăng nhập hoặc mật khẩu không chính xác!";
      } else {
        status = 3;
      }
      notifyListeners();
    // ignore: empty_catches
    } catch (e) {}
  }
}
