import 'package:flutter/material.dart';

class Themes {

  static final lightTheme = ThemeData(
    fontFamily: 'Nunito',
    backgroundColor: const Color(0XFFEAEAEA),
    shadowColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0XFF2A2B2E),
      selectionHandleColor: Color(0XFF2A2B2E),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Nunito',
    backgroundColor: const Color(0XFF2A2B2E),
    shadowColor: Colors.black,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0XFFEAEAEA),
      selectionHandleColor: Color(0XFFD9D9D9),
    ),
  );

}