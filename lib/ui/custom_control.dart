import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required TextEditingController textController,
      required this.hintText,
      required this.obscureText})
      : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: AppConstant.thirdColor,
          borderRadius: BorderRadius.circular(14)),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: AppConstant.secondaryColor,
              borderRadius: BorderRadius.circular(14)),
          child: TextField(
            obscureText: obscureText,
            controller: _textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppConstant.textLinkDark,
            ),
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
  });
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppConstant.thirdColor,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text(
        textButton,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      )),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/icon_neon.png'),
      width: 100,
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color:  Color.fromARGB(255, 40, 148, 255).withOpacity(0.3),
      child: const Center(
        child: Image(
          image: AssetImage('assets/images/Spinner.gif'),
          width: 80,
        ),
      ),
    );
  }
}
