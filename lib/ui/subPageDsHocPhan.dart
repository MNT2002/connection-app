import 'package:connection/models/course.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/repositories/course_repository.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppConstant.dart';

class SubPageDsHocPhan extends StatelessWidget {
  SubPageDsHocPhan({super.key});
  static int idPage = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.secondaryColor,
        title: Text(
          'Danh Sách Học Phần',
          style: TextStyle(color: AppConstant.textColor, fontWeight: FontWeight.bold,),
        ),
      ),
      body: FutureBuilder(
        // Hiển thị dữ liệu được tải từ Future
        future: CourseRepository().getListCourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomSpinner(size: size);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Course> courses = snapshot.data as List<Course>;
            return Container(color: AppConstant.mainColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số cột trong mỗi dòng
                    crossAxisSpacing: 16.0, // Khoảng cách giữa các cột
                    mainAxisSpacing: 16.0, // Khoảng cách giữa các dòng
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: AppConstant.textColor,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: AppConstant.thirdColor.withOpacity(0.5),
                      child: ListTile(
                        title: Text(
                          courses[index].tenhocphan,
                          style: TextStyle(
                            color: AppConstant.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Text(
                          'Giảng viên: ${courses[index].tengv}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
