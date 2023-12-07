import 'package:connection/models/profile.dart';
import 'package:connection/providers/diaChiModel.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/providers/profileViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubPageProfile extends StatelessWidget {
  const SubPageProfile({super.key});
  static int idPage = 1;

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
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.mainColor,
          child: Stack(
            children: [
              Column(
                children: [
                  // -- start header --
                  createHeader(size, profile),
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
                              width: size.width * 0.42,
                              callback: (output) {
                                profile.user.phone = output;
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
                                viewModel.updateScreen();
                              },
                              type: TextInputType.datetime,
                            ),
                          ],
                        ),
                        Row(
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
                                  viewModel.hideSpinner();
                                }),
                                list: diaChiModel.listCity)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              viewModel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          )),
    );
  }

  Container createHeader(Size size, Profile profile) {
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
                  child: CustomeAvatarProfile(size: size),
                ),
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
                )
              ],
            )
          ]),
    );
  }
}
