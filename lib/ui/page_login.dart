import 'package:connection/providers/loginViewModel.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodel.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (content) => const pageMain(),
              ));
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_tree,
                        size: 100,
                        color: Colors.deepPurple[400],
                      ),
                      const Text(
                        "Xin chào",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Chúng tôi rất nhớ bạn!",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // ignore: avoid_unnecessary_containers
                      CustomeTextField(
                        emailController: _emailController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeTextField(
                        emailController: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      viewmodel.status == 2
                          ? Text(viewmodel.errorMessage, style: const TextStyle(color: Colors.red),)
                          : const Text(""),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            String username = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            viewmodel.login(username, password);
                          },
                          child: const CustomButton(textButton: "Đăng nhập",),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Chưa có tài khoản? "),
                          Text(
                            "Đăng ký",
                            style: TextStyle(fontWeight:FontWeight.bold, color: Colors.deepPurple[300]),
                          )
                        ],
                      )
                    ],
                  ),
                  viewmodel.status == 1
                      ? Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.deepPurple.withOpacity(0.3),
                          child: const Center(
                            child: Image(
                              image: AssetImage('assets/images/Spinner.gif'),
                              width: 60,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }
}