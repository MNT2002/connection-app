import 'package:connection/models/course.dart';
import 'package:connection/services/api_services.dart';

class CourseRepository {
  Future<List<Course>> getListCourse() async {
    List<Course> list = [];
    var datas = await ApiService().getCourseList();
    if(datas != null) {
      for(var item in datas) {
        var course = Course.fromJson(item);
        list.add(course);
      }
    }
    return list;
  }
}