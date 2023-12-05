import 'package:connection/repositories/register_repositories.dart';
import 'package:flutter/material.dart';

class ResgisterViewModel with ChangeNotifier {
  int status =
      0; // 0: chua dang ky, 1: dang ki, 2: dang ki loi, 3: dk can xac minh email, 4: dk khong can xac minh email
  String errorMessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quyDinh =
      "Khi tham gia vào ứng dụng các bạn đồng ý với các điều khoản sau: \n" +
          "1. Các thông tin của bạn sẽ được chia sẽ với các thành viên học \n" +
          "2. Thông tin của bạn có thẻ ảnh hưởng học tập ở trường" +
          "3. Thông tin của bạn sẽ được xóa vĩnh viễn khi có yêu cầu xóa thông tin";
  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(String email, String username, String password,
      String confirmPassword) async {
    status = 1;
    notifyListeners();
    errorMessage = "";
    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      status = 2;
      errorMessage += "Email, username, password không được để trống!\n";
    } else {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (emailValid == false) {
        status = 2;
        errorMessage += "Email không hợp lệ! \n";
      }

      if (password.length < 8) {
        status = 2;
        errorMessage += "Mật khẩu cần có độ dài ít nhất 8 kí tự! \n";
      } else {
        if (password != confirmPassword) {
          status = 2;
          errorMessage = "Mật khẩu không giống nhau!";
        } else {
          if (agree == false) {
            status = 2;
            errorMessage += "Bạn phải đồng ý điều khoản trước khi đăng ký!\n";
          }
        }
      }
    }

    if (status == 1) {
      status = await registerRepo.register(email, username, password); // Sử dụng repository gọi hàm register và lấy kết quả
    }

    notifyListeners();
  }
}
