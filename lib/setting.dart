import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
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
  final getStorage = GetStorage();
  //late File _image;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    var fullname = data!['fullname'];
    var email = data['email'];
    var profilepicture = data['profilepicture'];
    var location = data['location'];
    setState(() {
      print([fullname, email, profilepicture, location]);
      getStorage.write("fullname", fullname);
      getStorage.write("email", email);
      getStorage.write("profilepicture", profilepicture);
      getStorage.write("location", location);
/*
      String imageBs4str = getStorage.read("profilepicture").toString();
      Uint8List decodedbytes = base64.decode(imageBs4str);
      File decodedimgfile =
          File("image.jpg").writeAsBytes(decodedbytes) as File;
      String decodedpath = decodedimgfile.path;
      getStorage.write("image_profilepicture", decodedpath);
      print(decodedpath);
      */
    });
  }

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
                  child: /*getStorage.read("profilepicture") != null
                          ? CircleAvatar(
                              radius: 75.0,
                              backgroundColor: Colors.black,
                              backgroundImage: Image.file(
                                _image,
                              );
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            )
                          : */
                      CircleAvatar(
                    backgroundColor: getStorage.read("changeColor")
                        ? const Color(0XFFA3333D)
                        : const Color(0XFF613DC1),
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
                  child: Text(
                    getStorage.read("fullname"),
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                getStorage.read("location").toString() == "null"
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36.0),
                        child: TextButton(
                          onPressed: () => Get.to(const EditProfile()),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).backgroundColor),
                          ),
                          child: Text(
                            'Select location',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36.0),
                        child: Text(
                          getStorage.read("location"),
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            decoration: TextDecoration.underline,
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
                          color: getStorage.read("changeColor")
                              ? const Color(0XFFA3333D)
                              : const Color(0XFF613DC1),
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
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/app_theme.svg',
                          color: getStorage.read("changeColor")
                              ? const Color(0XFFA3333D)
                              : const Color(0XFF613DC1),
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
                      contentPadding:
                          const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFFFFFDFA),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/log_out.svg',
                          color: getStorage.read("changeColor")
                              ? const Color(0XFFA3333D)
                              : const Color(0XFF613DC1),
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