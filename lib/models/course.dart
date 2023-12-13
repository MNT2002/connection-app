class Course {
  int id;
  String tenhocphan;
  String tengv;
  Course({this.id = 0, this.tenhocphan = "", this.tengv = ""});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      tenhocphan: json['tenhocphan'],
      tengv: json['tengv'],
    );
  }
}
