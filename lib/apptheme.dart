import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/setting.dart';
import 'package:notely/theme_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Sky { sun, moon }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.sun: const Color(0XFFFFC841),
  Sky.moon: const Color(0XFF2A2B2E),
};

class AppTheme extends StatefulWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  final _fromKey = GlobalKey<FormState>();
  final getStorage = GetStorage();
  bool changeStorage = GetStorage().read("changeColor");

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
          'Change Theme',
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
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 72.0),
                child: Text(
                  'Select white or dark theme',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                width: 150,
                alignment: Alignment.center,
                child: CupertinoSlidingSegmentedControl<Sky>(
                  backgroundColor: CupertinoColors.systemGrey,
                  thumbColor: skyColors[Theme.of(context).backgroundColor ==
                          const Color(0XFFEAEAEA)
                      ? Sky.sun
                      : Sky.moon]!,
                  groupValue: Theme.of(context).backgroundColor ==
                          const Color(0XFFEAEAEA)
                      ? Sky.sun
                      : Sky.moon,
                  onValueChanged: (Sky? value) {
                    if (value != null) {
                      setState(() {
                        ThemeService().changeThemeMode();
                      });
                    }
                  },
                  children: <Sky, Widget>{
                    Sky.sun: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(
                        'assets/images/sun.svg',
                        color: Theme.of(context).backgroundColor ==
                                const Color(0XFFEAEAEA)
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    Sky.moon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(
                        'assets/images/moon.svg',
                        color: Theme.of(context).backgroundColor ==
                                const Color(0XFFEAEAEA)
                            ? Colors.transparent
                            : Colors.white,
                      ),
                    ),
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Text(
                  'Select color palette',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: 6.0),
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(16.0),
                      color: const Color(0XFF613DC1),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        onPressed: () {
                          setState(() {
                            getStorage.write("changeColor", false);
                            changeStorage = false;
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/images/check.svg',
                          color: changeStorage
                              ? Colors.transparent
                              : const Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(left: 6.0),
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(16.0),
                      color: const Color(0XFFA3333D),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        onPressed: () {
                          setState(() {
                            getStorage.write("changeColor", true);
                            changeStorage = true;
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/images/check.svg',
                          color: changeStorage
                              ? const Color(0XFFFFFDFA)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}