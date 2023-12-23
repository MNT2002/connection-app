import 'package:connection/models/profile.dart';
import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  static final MainViewModel _instance = MainViewModel._internal();
  MainViewModel._internal();
  factory MainViewModel() {
    return _instance;
  }
  bool menuStatus = false; // false: close, true: open
  int activeMenu = 0; // index của menu item
  void toggleMenu() {
    menuStatus = !menuStatus;
    notifyListeners();
  }

  void closeMenu() {
    menuStatus = false;
    notifyListeners();
  }

  void setActiveMenu(int index) {
    activeMenu = index;
    menuStatus = false;
    notifyListeners();
  }

  void logOut() {
    Profile().token = "";
    notifyListeners();
  }
}
