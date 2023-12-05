import 'package:connection/models/profile.dart';
import 'package:connection/providers/resgisterViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageRegister extends StatelessWidget {
  PageRegister({super.key});
  static String routeName = '/register';
  final _usernameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _passControler = TextEditingController();
  final _confirmPassControler = TextEditingController();
  bool agree = true;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ResgisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();

    if (profile.token != "") // Kiểm tra đã đăng nhập chưa?
    {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (content) => PageMain(),
              ));
        },
      );
    }

    return Scaffold(
        backgroundColor: AppConstant.mainColor,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                  child: SingleChildScrollView(
                child: viewModel.status == 3 || viewModel.status == 4
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            const Image(
                              image: AssetImage('assets/images/check.gif'),
                              width: 100,
                            ),
                            Text(
                              "Đăng ký thành công!",
                              style: AppConstant.textFancyheader,
                            ),
                            viewModel.status == 3
                                ? const Text(
                                    "Bạn cần xác nhận email để hoàn thành đăng kí!")
                                : const Text(""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.popAndPushNamed(
                                      context, PageLogin.routeName),
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
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppLogo(),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Thêm người dùng mới',
                                style: AppConstant.textFancyheader),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                                textController: _emailControler,
                                hintText: 'Email',
                                obscureText: false),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                                textController: _usernameControler,
                                hintText: 'Username',
                                obscureText: false),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                                textController: _passControler,
                                hintText: 'Password',
                                obscureText: true),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                                textController: _confirmPassControler,
                                hintText: 'Confirm password',
                                obscureText: true),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: viewModel.agree,
                                  onChanged: (value) {
                                    viewModel.setAgree(value!);
                                  },
                                ),
                                const Text('Đồng ý', style: TextStyle(color: Colors.white),),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const SingleChildScrollView(
                                              child: Text("Quy định")),
                                          content: Text(viewModel.quyDinh),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      ' quy định',
                                      style: AppConstant.textLink,
                                    ))
                              ],
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
                                  final email = _emailControler.text.trim();
                                  final username =
                                      _usernameControler.text.trim();
                                  final password = _passControler.text.trim();
                                  final confirmPassword =
                                      _confirmPassControler.text.trim();
                                  viewModel.register(email, username, password,
                                      confirmPassword);
                                },
                                child:
                                    const CustomButton(textButton: 'Đăng ký')),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text("Bạn đã có tài khoản?" , style: TextStyle(color: Colors.white)),
                                GestureDetector(
                                  onTap: () => Navigator.popAndPushNamed(
                                      context, PageLogin.routeName),
                                  child: Text(
                                    " Đăng nhập" ,
                                    style: AppConstant.textLink,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              )),
              viewModel.status == 1
                  ? CustomSpinner(
                      size: size,
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
