class StudentFromDSLop {
  int id;
  String first_name;
  String last_name;
  String mssv;
  StudentFromDSLop(
      {this.id = 0,
      this.first_name = "",
      this.last_name = "",
      this.mssv = ""});
  factory StudentFromDSLop.fromJson(Map<String, dynamic> json) {
    return StudentFromDSLop(
        id: json['iduser'] ?? 0,
        first_name: json['first_name'] ?? '',
        last_name: json['last_name'] ?? '',
        mssv: json['mssv'] ?? '',
       );
  }
}
