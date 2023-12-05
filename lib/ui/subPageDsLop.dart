import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

import '../providers/mainViewModel.dart';

class SubPageDsLop extends StatelessWidget {
  const SubPageDsLop({super.key});
  static int idPage = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor,
          child: Center(
            child: Text("DsLop", style: TextStyle(color: Colors.white),),
          )),
    );
  }
}