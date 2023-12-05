import 'package:connection/repositories/forgot_pass_repository.dart';
import 'package:flutter/material.dart';

class ForgotPassViewModel with ChangeNotifier {
  // Kế thừa lại class ChangeNotifier
  final forgotPassRepo = ForgotPassRepository();
  int status = 0; // 0: chua gui, 1: dang gui, 2: loi, 3: thanh cong
  String errorMessage = "";

  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errorMessage = "";

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (emailValid == false) {
      status = 2;
      errorMessage += "Email không hợp lệ! \n";
    }
    if (status != 2) {
      print(await forgotPassRepo.forgotPassword(email));
      if (await forgotPassRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errorMessage += "Email không tồn tại! \n";
      }
    }
    notifyListeners();
  }
}
