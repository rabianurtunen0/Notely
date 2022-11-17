import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notely/createaccount.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LightDarkTheme();
  }
}

class LightDarkTheme extends StatefulWidget {
  const LightDarkTheme({
    Key? key,
  }) : super(key: key);

  @override
  State<LightDarkTheme> createState() => _LightDarkThemeState();
}

ThemeData _lightTheme = ThemeData(
  fontFamily: 'Nunito',
  backgroundColor: const Color(0XFFEAEAEA),
  highlightColor: const Color(0XFFA3333D),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0XFF2A2B2E),
    selectionHandleColor: Color(0XFF2A2B2E)
  ),
);

ThemeData _darkTheme = ThemeData(
  fontFamily: 'Nunito',
  backgroundColor: const Color(0XFF2A2B2E),
  highlightColor: const Color(0XFFA3333D),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0XFFEAEAEA),
    selectionHandleColor: Color(0XFFD9D9D9),
  ),
);

bool _light = true;

class _LightDarkThemeState extends State<LightDarkTheme> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notely',
      debugShowCheckedModeBanner: false,
      theme: _light ? _lightTheme : _darkTheme,
      home: const CreateAccount(),
    );
  }
}
