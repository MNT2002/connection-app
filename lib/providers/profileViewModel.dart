import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;
  void updateScreen() {
    notifyListeners();
  }
  void displaySpinner() {
    status = 1;
    notifyListeners();
  }
  void hideSpinner() {
    status = 0;
    notifyListeners();
  }
}