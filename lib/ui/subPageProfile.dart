import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class SubPageProfile extends StatelessWidget {
  const SubPageProfile({super.key});
  static int idPage = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor,
          child: Center(
            child: Text("Profile", style: TextStyle(color: Colors.white),),
          )),
    );
  }
}
