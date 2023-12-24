// ignore: camel_case_types
import 'package:avatar_glow/avatar_glow.dart';
import 'package:connection/models/profile.dart';
import 'package:connection/models/student.dart';
import 'package:connection/models/user.dart';
import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/providers/menuBarViewModel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_dkLop.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/subPageDiemDanh.dart';
import 'package:connection/ui/subPageDsHocPhan.dart';
import 'package:connection/ui/subPageDsLop.dart';
import 'package:connection/ui/subPageMain.dart';
import 'package:connection/ui/subPageProfile.dart';
import 'package:connection/ui/subPageSetting.dart';
import 'package:connection/ui/subPageTimKiem.dart';
import 'package:flutter/material.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class PageMain extends StatefulWidget {
  PageMain({super.key});
  static String routeName = '/home';

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final List<String> menuTitles = [
    "Profile",
    "Danh sách lớp",
    "Danh sách học phần",
    "Đăng xuất"
  ];
  int currentIndex = 0; // Track the current index for the selected item
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final menuBar = MenuItemList();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewModel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return PageLogin();
    }

    if (profile.student.mssv == "") {
      return PageDangKyLop();
    }

    // Widget body = SubPageMain();
    // if (viewModel.activeMenu == SubPageProfile.idPage) {
    //   body = SubPageProfile();
    // } else if (viewModel.activeMenu == SubPageDsLop.idPage) {
    //   body = SubPageDsLop();
    // } else if (viewModel.activeMenu == SubPageDsHocPhan.idPage) {
    //   body = SubPageDsHocPhan();
    // } else if (viewModel.activeMenu == 4) {
    //   MainViewModel().logOut();
    // }
    Widget body = SubPageMain();
    switch (currentIndex) {
      case 0:
        body = SubPageMain();
      case 1:
        body = SubPageProfile();
      case 2:
        body = SubPageDsLop();
      case 3:
        body = SubPageDsHocPhan();
      case 4:
        body = SubPageSetting();
      default:
        return Container();
    }

    menuBar.initialize(menuTitles);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.secondaryColor,
        leading: GestureDetector(
          onTap: () => {viewModel.toggleMenu()},
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        unselectedItemColor: AppConstant.textColor,
        selectedItemColor: Colors.pink,
        backgroundColor: AppConstant.secondaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.class_rounded), label: 'DS Lớp'),
          BottomNavigationBarItem(
              icon: Icon(Icons.subject), label: 'DS HP'), // New item
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Cài Đặt'), // New item
        ],
      ),
      drawer: const Drawer(
        child: Text('drawer menu'),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: AppConstant.mainColor,
            child: Center(
              child: body,
            ),
          ),
          viewModel.menuStatus == true
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                      onPanUpdate: (details) {
                        menuBarModel.setOffset(details.localPosition);
                      },
                      onPanEnd: (details) {
                        menuBarModel.setOffset(const Offset(0, 0));
                        viewModel.closeMenu();
                      },
                      child: Stack(
                        children: [CustomMenusideBar(size: size), menuBar],
                      ),
                    );
                  },
                )
              : Container()
        ],
      )),
    );
  }
}

class MenuItemList extends StatelessWidget {
  MenuItemList({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idPage: i,
        containerKey: GlobalKey(),
        title: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.67,
            child: Center(
              child: AvatarGlow(
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                endRadius: size.height * 0.3,
                glowColor: AppConstant.mainColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.height),
                  child: SizedBox(
                      height: size.height * 0.16,
                      width: size.height * 0.16,
                      child: CustomeAvatarProfile(
                        size: size,
                      )),
                ),
              ),
            ),
          ),
          Container(
            height: 2,
            width: size.width * 0.65,
            color: AppConstant.mainColor,
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: size.height * 0.6,
            width: size.width * 0.65,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuBarItems.length,
                itemBuilder: (context, index) {
                  return menuBarItems[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerKey,
    required this.idPage,
  });
  final int idPage;
  final String title;
  final GlobalKey containerKey;
  TextStyle style = AppConstant.textBody;

  void onPanMove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textBody;
    }
    if (containerKey.currentContext != null) {
      RenderBox box =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textBodyFocus;
        MainViewModel().activeMenu = idPage;
      } else {
        style = AppConstant.textBody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanMove(menuBarModel.offset);

    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idPage),
      child: Container(
        key: containerKey,
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenusideBar extends StatelessWidget {
  const CustomMenusideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double result = 0;
    if (offset.dx == 0) {
      result = width;
    } else if (offset.dx < width) {
      result = width + 75;
    } else {
      result = offset.dx;
    }
    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
