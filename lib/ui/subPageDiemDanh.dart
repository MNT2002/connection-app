import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class SubPageDiemDanh extends StatelessWidget {
  const SubPageDiemDanh({super.key});
  static int idPage = 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor,
          child: Center(
            child: Text("DiemDanh", style: TextStyle(color: Colors.white),),
          )),
    );
  }
}
