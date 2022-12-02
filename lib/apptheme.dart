import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/setting.dart';
import 'package:notely/theme_service.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppTheme extends StatefulWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.to(const Setting()),
          icon: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          splashRadius: 25.0,
        ),
        title: Text(
          'App Theme',
          style: TextStyle(
            fontFamily: 'Titan One',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 32.0),
                  child: CircleAvatar(
                    backgroundImage: Theme.of(context).backgroundColor == const Color(0XFFEAEAEA)
                        ? const AssetImage('assets/images/sun.png')
                        : const AssetImage('assets/images/moon.png'),
                    backgroundColor: Colors.transparent,
                    radius: 75.0,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                  child: Text(
                    'Choose a style',
                    style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Day or night. Light or dark. Customize your interface',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textSelectionTheme
                          .selectionHandleColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(96.0, 32.0, 96.0, 32.0),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ThemeService().changeThemeMode();
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.fromLTRB(
                                    28.0, 0.0, 38.0, 0.0),
                                child: const Text(
                                  'Light',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.fromLTRB(
                                    42.0, 0.0, 22.0, 0.0),
                                child: const Text(
                                  'Dark',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedAlign(
                        alignment: Theme.of(context).backgroundColor == const Color(0XFFEAEAEA)
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5.0),
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  blurRadius: 12.0,
                                  spreadRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Text(
                              Theme.of(context).backgroundColor == const Color(0XFFEAEAEA) ? 'Light' : 'Dark',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
