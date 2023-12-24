import 'package:connection/models/lop.dart';
import 'package:connection/models/studentFromDSLop.dart';
import 'package:connection/repositories/class_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';

import '../providers/mainViewModel.dart';

class SubPageDsLop extends StatefulWidget {
  SubPageDsLop({super.key});
  static int idPage = 2;

  @override
  State<SubPageDsLop> createState() => _SubPageDsLopState();
}

class _SubPageDsLopState extends State<SubPageDsLop> {
  int idLop = 0;
  String tenLop = '';

  @override
  Widget build(BuildContext context) {
    final ClassRepository classRepository = ClassRepository();
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.secondaryColor,
          title: idLop == 0
              ? Text(
                  'Danh Sách Lớp',
                  style: TextStyle(
                    color: AppConstant.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: idLop != 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  idLop = 0;
                                  tenLop = '';
                                });
                              },
                              child: Icon(Icons.arrow_back,
                                  color: Color.fromARGB(255, 216, 222, 227)))
                          : Container(),
                    ),
                    Text(
                      'Danh Sách SV Lớp "${tenLop}"',
                      style: TextStyle(
                        color: AppConstant.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
        body: idLop == 0
            ? FutureBuilder(
                // Hiển thị dữ liệu được tải từ Future
                future: classRepository.getListClass(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomSpinner(size: size);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Lop> courses = snapshot.data as List<Lop>;
                    return Container(
                      color: AppConstant.mainColor,
                      child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                idLop = courses[index].id;
                                tenLop = courses[index].ten;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: size.width,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppConstant.textColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppConstant.thirdColor.withOpacity(0.5),
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Center(
                                    child: Text(
                                  courses[index].ten,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppConstant.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                )),
                                // Các thuộc tính khác của Course có thể được hiển thị ở đây
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            : FutureBuilder(
                // Hiển thị dữ liệu được tải từ Future
                future: StudentRepository().GetStudentsFromDSLop(idLop),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomSpinner(size: size);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<StudentFromDSLop> studentList =
                        snapshot.data as List<StudentFromDSLop>;
                    return Container(
                      color: AppConstant.mainColor,
                      child: ListView.builder(
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstant.textColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppConstant.thirdColor.withOpacity(0.5),
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: studentList[index].first_name != ""
                                  ? Text(
                                      'Họ tên: ${studentList[index].first_name}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppConstant.secondaryColor),
                                    )
                                  : Text(
                                      'Họ tên: "Trống!"',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppConstant.secondaryColor),
                                    ),
                              subtitle: Text(
                                'Mssv: ${studentList[index].mssv}',
                                style: TextStyle(
                                    color: AppConstant.secondaryColor),
                              ),
                              // Các thuộc tính khác của Course có thể được hiển thị ở đây
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ));
  }
}

class CourseListModel {}
