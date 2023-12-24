import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class SubPageSetting extends StatelessWidget {
  const SubPageSetting({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildSettingsItem(
            context,
            'Cài đặt chung',
            Icons.settings,
            () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertMaintenance(context, 'Cài đặt chung');
                },
              );
            },
          ),
          const SizedBox(height: 20.0), // Khoảng cách giữa các mục
          buildSettingsItem(
            context,
            'Trung tâm trợ giúp',
            Icons.support,
            () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertMaintenance(context,'Trung tâm trợ giúp');
                },
              );
            },
          ),
          const SizedBox(height: 20.0), // Khoảng cách giữa các mục
          buildSettingsItem(
            context,
            'Báo cáo sự cố',
            Icons.warning_amber,
            () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertMaintenance(context,'Báo cáo sự cố');
                },
              );
            },
          ),
          const SizedBox(height: 20.0), // Khoảng cách giữa các mục
          buildSettingsItem(
            context,
            'Đăng xuất',
            Icons.exit_to_app,
            () {
              showLogoutConfirmDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildSettingsItem(
      BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(26.0),
        decoration: BoxDecoration(
          color: AppConstant.textColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppConstant.thirdColor.withOpacity(0.5),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey), // Icon mũi tên
          ],
        ),
      ),
    );
  }

  void showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận đăng xuất'),
          content: Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // Thực hiện hành động khi xác nhận đăng xuất
                MainViewModel().logOut();
                Navigator.pop(
                    context); // Quay lại màn hình trước (tắt box chọn)
              },
              child: Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }
}

Widget alertMaintenance(BuildContext context, String text) {
  return AlertDialog(
    title: Text('Thông báo'),
    content: Text('${text} đang bảo trì!'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Đóng hộp thoại
        },
        child: Text('Đóng'),
      ),
    ],
  );
}
