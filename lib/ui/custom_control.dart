import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField(
      {super.key,
      required TextEditingController emailController,
      required this.hintText,
      required this.obscureText})
      : _emailController = emailController;

  final TextEditingController _emailController;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20), // padding đối xứng 2 bên
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(14)),
          child: TextField(
            obscureText: obscureText,
            controller: _emailController,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
          )),
    );
  }
}


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.textButton,
  });
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text(
        textButton,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      )),
    );
  }
}
