import 'package:connection/providers/mainViewModel.dart';
import 'package:flutter/material.dart';

import 'AppConstant.dart';

class SubPageDsHocPhan extends StatelessWidget {
  const SubPageDsHocPhan({super.key});
  static int idPage = 5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor,
          child: Center(
            child: Text("DsHocPhan" ,style: TextStyle(color: Colors.white),),
          )),
    );
  }
}