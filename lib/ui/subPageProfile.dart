import 'dart:io';

import 'package:connection/models/profile.dart';
import 'package:connection/providers/diaChiModel.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/providers/profileViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idPage = 1;
  XFile? image;

  Future<void> init(DiaChiModel diaChiModel, ProfileViewModel viewModel) async {
    Profile profile = Profile();
    if (diaChiModel.listCity.isEmpty ||
        diaChiModel.curCityId != profile.user.provinceid ||
        diaChiModel.curDistrictId != profile.user.districtid ||
        diaChiModel.curWardId != profile.user.wardid) {
      viewModel.displaySpinner();
      await diaChiModel.initialize(profile.user.provinceid,
          profile.user.districtid, profile.user.wardid);
      viewModel.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final diaChiModel = Provider.of<DiaChiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(diaChiModel, viewModel));
    return Container(
        color: AppConstant.mainColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // -- start header --
                  createHeader(size, profile, viewModel),
                  // End header
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomInputTextFormField(
                              title: 'Điện thoại',
                              value: profile.user.phone,
                              width: size.width * 0.45,
                              callback: (output) {
                                profile.user.phone = output;
                                viewModel.setModified();
                                viewModel.updateScreen();
                              },
                              type: TextInputType.phone,
                            ),
                            CustomInputTextFormField(
                              title: 'Ngày sinh',
                              value: profile.user.birthday,
                              width: size.width * 0.45,
                              callback: (output) {
                                if (AppConstant.isDate(output)) {
                                  profile.user.birthday = output;
                                }
                                viewModel.setModified();
                                viewModel.updateScreen();
                              },
                              type: TextInputType.datetime,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPlaceDropDown(
                                width: size.width * 0.45,
                                title: "Thành phố/Tỉnh",
                                valueId: profile.user.provinceid,
                                valueName: profile.user.provincename,
                                callback: ((outputId, outputName) async {
                                  viewModel.displaySpinner();
                                  profile.user.provinceid = outputId;
                                  profile.user.provincename = outputName;
                                  await diaChiModel.setCity(outputId);
                                  profile.user.districtid = 0;
                                  profile.user.wardid = 0;
                                  profile.user.districtname = '';
                                  profile.user.wardname = '';
                                  viewModel.setModified();
                                  viewModel.hideSpinner();
                                }),
                                list: diaChiModel.listCity),
                            CustomPlaceDropDown(
                                width: size.width * 0.45,
                                title: "Quận/Huyện",
                                valueId: profile.user.districtid,
                                valueName: profile.user.districtname,
                                callback: ((outputId, outputName) async {
                                  viewModel.displaySpinner();
                                  profile.user.districtid = outputId;
                                  profile.user.districtname = outputName;
                                  await diaChiModel.setDistrict(outputId);
                                  profile.user.wardid = 0;
                                  profile.user.wardname = '';
                                  viewModel.setModified();
                                  viewModel.hideSpinner();
                                }),
                                list: diaChiModel.listDistrict),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPlaceDropDown(
                                width: size.width * 0.45,
                                title: "Huyện/Xã",
                                valueId: profile.user.wardid,
                                valueName: profile.user.wardname,
                                callback: ((outputId, outputName) async {
                                  viewModel.displaySpinner();
                                  profile.user.wardid = outputId;
                                  profile.user.wardname = outputName;
                                  await diaChiModel.setCity(outputId);
                                  viewModel.setModified();
                                  viewModel.hideSpinner();
                                }),
                                list: diaChiModel.listWard),
                            CustomInputTextFormField(
                              title: 'Tên đường/Số nhà',
                              value: profile.user.address,
                              width: size.width * 0.45,
                              callback: (output) {
                                profile.user.address = output;
                                viewModel.setModified();
                                viewModel.updateScreen();
                              },
                              type: TextInputType.phone,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: size.width * 0.3,
                            width: size.width * 0.3,
                            child: QrImageView(
                                data: '{userid:' +
                                    profile.user.id.toString() +
                                    '}',
                                version: QrVersions.auto,
                                gapless: false,
                                backgroundColor:
                                    const Color.fromARGB(255, 216, 222, 227)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            viewModel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ));
  }

  Container createHeader(
      Size size, Profile profile, ProfileViewModel viewModel) {
    return Container(
      height: size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppConstant.secondaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      profile.student.diem.toString(),
                      style: AppConstant.textLinkDark,
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: viewModel.updatedavatar == 1 && image != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(File(image!.path),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.upLoadAvatar(image!);
                                    },
                                    child: Container(
                                        color:
                                            Color.fromARGB(255, 216, 222, 227),
                                        child: Icon(size: 30, Icons.save)),
                                  ))
                            ],
                          )
                        : GestureDetector(
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              viewModel.setUpdateAvatar();
                            },
                            child: CustomeAvatarProfile(size: size))),
              ],
            ),
            Column(
              children: [
                Text(
                  profile.user.first_name,
                  style: AppConstant.textLinkDark,
                ),
                Row(
                  children: [
                    Text(
                      "Mssv: ",
                      style: AppConstant.textLinkDark,
                    ),
                    Text(
                      profile.student.mssv,
                      style: AppConstant.textLink,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Lớp: ",
                      style: AppConstant.textLinkDark,
                    ),
                    Text(
                      profile.student.tenLop,
                      style: AppConstant.textLink,
                    ),
                    profile.student.duyet == 0
                        ? Text(
                            " (Chưa duyệt)",
                            style: AppConstant.textLink,
                          )
                        : Text("")
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Vai trò: ",
                      style: AppConstant.textLinkDark,
                    ),
                    Text(
                      profile.user.role_id == 4 ? "Sinh viên" : "Giảng viên",
                      style: AppConstant.textLink,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: viewModel.modified == 1
                      ? GestureDetector(
                          onTap: () {
                            viewModel.updateProfile();
                          },
                          child: Icon(Icons.save,
                              color: Color.fromARGB(255, 216, 222, 227)))
                      : Container(),
                )
              ],
            ),
          ]),
    );
  }
}
