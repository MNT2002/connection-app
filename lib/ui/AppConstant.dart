import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textFancyheader = GoogleFonts.sourceSerif4(
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: const Color.fromARGB(255, 216, 222, 227));

  static TextStyle textError = TextStyle(
    color: Colors.red[300],
    fontSize: 16,
  );

  static TextStyle textLink =
      const TextStyle(color: Colors.green);
  static TextStyle textLinkDark =
      const TextStyle(color: Color.fromARGB(255, 216, 222, 227));

  static TextStyle textBody = const TextStyle(color:  Colors.green, fontSize: 16);
  static TextStyle textBodyFocus = const TextStyle(color: Color.fromARGB(255, 216, 222, 227), fontSize: 18);

  static Color mainColor = const Color.fromARGB(255, 31, 36, 45);
  static Color secondaryColor = const Color.fromARGB(255, 38, 44, 55);
  static Color thirdColor = const Color.fromARGB(255, 40, 148, 255);
  static Color textColor = const Color.fromARGB(255, 216, 222, 227);

  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      print('--- Loi ---');
      return false;
    }
  }
}
