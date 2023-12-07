import 'package:connection/models/lop.dart';
import 'package:connection/models/profile.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

class PageDangKyLop extends StatefulWidget {
  const PageDangKyLop({super.key});

  @override
  State<PageDangKyLop> createState() => _PageDangKyLopState();
}

class _PageDangKyLopState extends State<PageDangKyLop> {
  List<Lop>? listLop = [];
  Profile profile = Profile();
  String mssv ='';
    String ten = '';
    int idLop = 0;
    String tenLop = '';
  @override
  void initState() {
    // TODO: implement initState
     mssv = profile.student.mssv;
     ten = profile.user.first_name;
    idLop = profile.student.idLop;
     tenLop = profile.student.tenLop;
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Profile profile = Profile();
    

    return Scaffold(
      backgroundColor: AppConstant.mainColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Thêm thông tin cơ bản',
                    style: AppConstant.textFancyheader),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Bạn không thể quay trở lại trang sau khi rời đi. Hãy kiểm tra kỹ nhé!',
                  style: AppConstant.textError,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputTextFormField(
                  title: "Tên",
                  value: ten,
                  width: size.width,
                  callback: (output) {
                    ten = output;
                  },
                ),
                CustomInputTextFormField(
                  title: "Mssv",
                  value: mssv,
                  width: size.width,
                  callback: (output) {
                    mssv = output;
                  },
                ),
                listLop!.isEmpty
                    ? FutureBuilder(
                        future: LopRepository().getDsLop(),
                        builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            listLop = snapshot.data;
                            return CustomInputDropDown(
                                width: size.width,
                                list: listLop!,
                                title: "Lớp",
                                valueId: idLop,
                                valueName: tenLop,
                                callback: (outputId, outputName) {
                                  idLop = outputId;
                                  tenLop = outputName;
                                });
                          } else {
                            return Text("Lỗi xảy ra",
                                style: AppConstant.textError);
                          }
                        })
                    : CustomInputDropDown(
                        width: size.width,
                        list: listLop!,
                        title: "Lớp",
                        valueId: idLop,
                        valueName: tenLop,
                        callback: (outputId, outputName) {
                          idLop = outputId;
                          tenLop = outputName;
                        }),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () async {
                      profile.student.mssv = mssv;
                      profile.student.idLop = idLop;
                      profile.student.tenLop = tenLop;
                      profile.user.first_name = ten;
                      await UserRepository().updateProfile();
                      await StudentRepository().dangKyLop();
                    },
                    child: CustomButton(textButton: 'Lưu thông tin')),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, PageMain.routeName);
                  },
                  child: Text(
                    "Tới trang chủ >>",
                    style: AppConstant.textLink,
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

