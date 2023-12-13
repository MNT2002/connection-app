
import 'package:connection/models/course.dart';
import 'package:connection/repositories/course_repository.dart';
import 'package:flutter/foundation.dart';

class CourseListModel with ChangeNotifier {
  List<Course> listCourse = [];

  Future<void> initialize() async {
   
    final repo = CourseRepository();
    listCourse = await repo.getListCourse();
  }
}
