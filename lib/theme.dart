import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
    fontFamily: 'Nunito',
    backgroundColor: const Color(0XFFEAEAEA),
    highlightColor: const Color(0XFFA3333D),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0XFF2A2B2E),
      selectionHandleColor: Color(0XFF2A2B2E)
    ),
    shadowColor: Colors.white, 
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Nunito',
    backgroundColor: const Color(0XFF2A2B2E),
    highlightColor: const Color(0XFFA3333D),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0XFFEAEAEA),
      selectionHandleColor: Color(0XFFD9D9D9),
    ),
    shadowColor: Colors.black,
  );

}