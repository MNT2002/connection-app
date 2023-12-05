import 'package:connection/providers/forgotPassViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageForgotPass extends StatelessWidget {
  PageForgotPass({super.key});
  static String routeName = "/forgot";
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ForgotPassViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: viewModel.status == 3
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/check.gif'),
                            width: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Đã gửi yêu cầu lấy lại mật khẩu đến email của bạn, vui lòng truy cập email để xác thực!",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.popAndPushNamed(
                                      context, PageLogin.routeName)
                                },
                                child: Text(
                                  "Bấm vào đây ",
                                  style: AppConstant.textLink,
                                ),
                              ),
                              const Text("để đăng nhập"),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image:
                              AssetImage('assets/images/password-forgot.gif'),
                          width: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            "Hãy điền email để thực hiện quy trính tạo lại mật khẩu!"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            textController: _emailController,
                            hintText: 'Email',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          viewModel.errorMessage,
                          style: AppConstant.textError,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final email = _emailController.text.trim();
                            viewModel.forgotPassword((email));
                          },
                          child: const CustomButton(textButton: "Gửi yêu cầu"),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text("Bạn đã có tài khoản?"),
                            GestureDetector(
                              onTap: () => Navigator.popAndPushNamed(
                                  context, PageLogin.routeName),
                              child: Text(
                                " Đăng nhập",
                                style: AppConstant.textLink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            viewModel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    ));
  }
}
