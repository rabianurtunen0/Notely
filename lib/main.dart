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
  backgroundColor: const Color(0XFF2A2B2E),
  primaryColor: const Color(0XFFA3333D),
);

ThemeData _darkTheme = ThemeData(
  fontFamily: 'Nunito',
  backgroundColor: const Color.fromARGB(255, 163, 149, 124),
  primaryColor: const Color.fromARGB(255, 46, 70, 80),
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
