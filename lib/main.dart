import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/createaccount.dart';
import 'package:notely/startseite.dart';
import 'package:notely/theme.dart';
import 'package:notely/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  prefs.setBool("selected", false);
  final getStorage = GetStorage();
  // ignore: prefer_if_null_operators
  getStorage.read("changeColor") == null
      ? getStorage.write("changeColor", true)
      : getStorage.read("changeColor");
  // ignore: prefer_if_null_operators
  getStorage.read("changeView") == null
      ? getStorage.write("changeView", true)
      : getStorage.read("changeView");
  getStorage.write("isSelected", false);
  runApp(email == null ? const MyApp() : const MyAppPrivate());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notely',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeService().getThemeMode(),
      home: const CreateAccount(),
    );
  }
}

class MyAppPrivate extends StatelessWidget {
  const MyAppPrivate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notely',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeService().getThemeMode(),
      home: const StartSeite(),
    );
  }
}