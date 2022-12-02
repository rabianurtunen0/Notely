import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:notely/login.dart';
import 'package:notely/setting.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
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
          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 20.0),
                  child: CircleAvatar(
                        backgroundColor: Theme.of(context).highlightColor,
                        radius: 75.0,
                        child: Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/user.svg',
                            color: const Color(0XFFFFFDFA),
                          ),
                        ),
                      ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                  child: Text(
                    'Rabia Nur Tünen',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36.0),
                  child: Text(
                    'Konya, Turkey',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                Container(
                    margin:
                        const EdgeInsets.fromLTRB(120.0, 80.0, 120.0, 60.0),
                    alignment: Alignment.center,
                    child: Material(
                      elevation: 0,
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(24.0),
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          onPressed: () => Get.to(const Login()),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
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
                                  letterSpacing: 1.5,
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
