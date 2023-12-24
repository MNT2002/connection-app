import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class SubPageMain extends StatelessWidget {
  const SubPageMain({super.key});
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Container(
        color: AppConstant.mainColor,
        width: size.width,
        child: Image.asset('assets/images/home_page.jpg', fit: BoxFit.cover,)
    );
  }
}

