import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notely/apptheme.dart';
import 'package:notely/editprofile.dart';
import 'package:notely/logout.dart';
import 'package:notely/startseite.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
          onPressed: () => Get.to(const StartSeite()),
          icon: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          splashRadius: 25.0,
        ),
        title: Text(
          'NOTELY',
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
                  padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 20.0),
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
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  child: MaterialButton(
                    onPressed: () => Get.to(const EditProfile()),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/edit_profile.svg',
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/images/arrow_right.svg',
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  child: MaterialButton(
                    onPressed: () => Get.to(const AppTheme()),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/app_theme.svg',
                          color: Theme.of(context).highlightColor,
                          
                        ),
                      ),
                      title: Text(
                        'App Theme',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/images/arrow_right.svg',
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  child: MaterialButton(
                    onPressed: () => Get.to(const LogOut()),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/log_out.svg',
                          color: Theme.of(context).highlightColor,
                          
                        ),
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/images/arrow_right.svg',
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
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
