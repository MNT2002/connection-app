import 'dart:convert';

import 'package:connection/models/profile.dart';
import 'package:connection/models/student.dart';
import 'package:connection/models/studentFromDSLop.dart';
import 'package:connection/services/api_services.dart';

class StudentRepository {
  final ApiService api = ApiService();
  Future<bool> dangKyLop() async {
    bool kq = false;
    var response = await api.dangKyLop();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<Student> getStudentInfo() async {
    Student student = Student();
    var response = await api.getStudentInfo();
    if (response != null) {
      var data = response.data;
      student = Student.fromJson(data);
      // Profile().student = Student.fromStudent(student);
    }

    return student;
  }

  Future<List<StudentFromDSLop>> GetStudentsFromDSLop(int idLophoc) async {
    List<StudentFromDSLop> list = [];
    // list.add(StudentFromDSLop(id: 1, first_name: 'nhat', last_name: '', mssv: '20103135' ));
    var response = await ApiService().getStudentsFromDSLop(idLophoc);
    // print(response);
    if (response != null) {
      var data = response.data;
      List<dynamic> jsondata = json.decode(data);
      list = jsondata.map((e) => StudentFromDSLop.fromJson(e)).toList();
      return list;
    }
    return [];
  }
}
