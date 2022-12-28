import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/login.dart';
import 'package:notely/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final _fromKey = GlobalKey<FormState>();
  final getStorage = GetStorage();

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
          'Log Out',
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
          padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 16.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 25.0),
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    getStorage.read("changeColor") == true
                        ? 'assets/images/logout_picture1.svg'
                        : 'assets/images/logout_picture2.svg',
                  ),
                ),
                Container(
                    width: 152,
                    height: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 24.0),
                    child: Material(
                      elevation: 0,
                      color: getStorage.read("changeColor")
                          ? const Color(0XFFA3333D)
                          : const Color(0XFF613DC1),
                      borderRadius: BorderRadius.circular(12.0),
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove("email");
                            Get.to(const Login());
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 4.0, 8.0, 4.0),
                                child: SvgPicture.asset(
                                  'assets/images/log_out.svg',
                                  color: const Color(0XFFFFFDFA),
                                ),
                              ),
                              const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Color(0XFFFFFDFA),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          )),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
