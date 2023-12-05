import 'package:connection/models/lop.dart';
import 'package:connection/models/profile.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
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
                Text(
                  "Tới trang chủ",
                  style: AppConstant.textLink,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;
  final Function(int outputId, String outputName) callback;

  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textBody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "Không có" : outputName,
                  style: AppConstant.textBodyFocus,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppConstant.secondaryColor),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Container(
                              width: widget.width * 0.8,
                              child: Text(
                                e.ten,
                                overflow: TextOverflow.ellipsis,
                                style: AppConstant.textLink,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropItem in widget.list) {
                        if (dropItem.id == outputId) {
                          outputName = dropItem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                )),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFormField extends StatefulWidget {
  const CustomInputTextFormField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
  });

  final double width;
  final String title;
  final String value;
  final Function(String output) callback;

  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    output = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textBody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  output == "" ? "Không có" : output,
                  style: AppConstant.textBodyFocus,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstant.secondaryColor),
                    width: widget.width - 40,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          output = value;
                          widget.callback(output);
                        });
                      },
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: output,
                      style: AppConstant.textBodyFocus,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                        widget.callback(output);
                      });
                    },
                    child: Icon(
                      Icons.save,
                      size: 18,
                      color: AppConstant.thirdColor,
                    ),
                  )
                ],
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
