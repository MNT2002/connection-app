class Student {
  int idUser;
  String mssv;
  int idLop;
  String tenLop;
  int diem;
  int duyet;
  Student(
      {this.idUser = 0,
      this.mssv = "",
      this.idLop = 0,
      this.tenLop = "",
      this.diem = 0,
      this.duyet = 0});
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        idUser: json['iduser'],
        mssv: json['mssv'],
        idLop: json['idlop'],
        tenLop: json['lop'],
        diem: json['diem'],
        duyet: json['duyet']);
  }
  factory Student.fromStudent(Student student) {
    return Student(
        idUser: student.idUser,
        mssv: student.mssv,
        idLop: student.idLop,
        tenLop: student.tenLop,
        diem: student.diem,
        duyet: student.duyet);
  }
}
