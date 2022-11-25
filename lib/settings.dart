import 'package:flutter/material.dart';
import 'package:notely/apptheme.dart';
import 'package:notely/editprofile.dart';
import 'package:notely/logout.dart';
import 'package:notely/startseite.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
          icon: ImageIcon(
            const AssetImage('assets/images/arrow_left.png'),
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
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/people.png'),
                    radius: 75.0,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: ImageIcon(
                          const AssetImage('assets/images/editprofile.png'),
                          color: Theme.of(context).highlightColor,
                          size: 32.0,
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
                      trailing: ImageIcon(
                        const AssetImage('assets/images/arrow_right.png'),
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: ImageIcon(
                          const AssetImage('assets/images/apptheme.png'),
                          color: Theme.of(context).highlightColor,
                          size: 32.0,
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
                      trailing: ImageIcon(
                        const AssetImage('assets/images/arrow_right.png'),
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: ImageIcon(
                          const AssetImage('assets/images/logout.png'),
                          color: Theme.of(context).highlightColor,
                          size: 32.0,
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
                      trailing: ImageIcon(
                        const AssetImage('assets/images/arrow_right.png'),
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
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
