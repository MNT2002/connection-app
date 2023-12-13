
import 'package:connection/repositories/course_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mainViewModel.dart';

class SubPageDsLop extends StatelessWidget {
  const SubPageDsLop({super.key});
  static int idPage = 4;

  @override
  Widget build(BuildContext context) {
    final courseListModel = CourseRepository().getListCourse();

    print(courseListModel);
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor, child: Center(child: Container())),
    );
  }
}

class CourseListModel {}
