import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notely/setting.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  var user = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.email)
      .get()
      .then((data) => data['fullname'].toString().toString());

  Future<String> getUserNameFromUID(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .get();
    return snapshot.docs.first['fullname'].toString().trim();
  }

  late String getFullName = "";
  var getLocation = "";

  String listData = '';

  List<String> list_data = [];

  Future<List<dynamic>> getData() async {
    List<dynamic> degerler = [];

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      degerler.addAll(value.data()!.values.toList());
      listData = value.data()!.values.toList()[3];
      getFullName = value.data()!.values.toList()[3];
    });
    // ignore: avoid_print, prefer_interpolation_to_compose_strings

    return degerler;
  }

  Future<String> testtttt() async {
    var asd = await getData();

    List<String> temp = List<String>.from(asd);
    print(temp);
    getFullName = temp[3];
    return "asd";
  }

  late final fullNameEditingController =
      TextEditingController(text: getFullName);
  final emailEditingController =
      TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
  late final locationEditingController =
      TextEditingController(text: getLocation);

  final oldPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();
  final newPasswordAgainEditingController = TextEditingController();

  final _scrollController = ScrollController();
  final _fromKey = GlobalKey<FormState>();
  bool _isVisible = true;

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
          'Edit Profile',
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
            child: Scrollbar(
              controller: _scrollController,
              thickness: 5,
              radius: const Radius.circular(20.0),
              scrollbarOrientation: ScrollbarOrientation.right,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 12.0),
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
                      child: TextButton(
                        onPressed: () {
                          bottomSheet();
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).backgroundColor),
                        ),
                        child: Text(
                          'Change Photo',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 45.0, 0.0, 8.0),
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: fullNameEditingController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "⛔ This field is required";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          fullNameEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 27.0, 0.0, 8.0),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: emailEditingController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "⛔ This field is required";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "⛔ Please enter a valid email adress";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          fullNameEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 27.0, 0.0, 8.0),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: locationEditingController,
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) {
                          locationEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0.0, 43.0, 0.0, 28.0),
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 0.0, 0.0, 8.0),
                      child: Text(
                        'Old Password',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: oldPasswordEditingController,
                        keyboardType: TextInputType.text,
                        obscureText: _isVisible,
                        obscuringCharacter: '#',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{8,}$');
                          if (value!.isEmpty) {
                            return "⛔ This field is required";
                          }
                          if (!regex.hasMatch(value)) {
                            return "⛔ Enter valid password(Minimum 8 characters)";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          oldPasswordEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          hintText: '##########',
                          hintStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0XFF595550),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0XFF595550),
                            ),
                            splashColor: Colors.transparent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 27.0, 0.0, 8.0),
                      child: Text(
                        'New Password',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: newPasswordEditingController,
                        keyboardType: TextInputType.text,
                        obscureText: _isVisible,
                        obscuringCharacter: '#',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{8,}$');
                          if (value!.isEmpty) {
                            return "⛔ This field is required";
                          }
                          if (!regex.hasMatch(value)) {
                            return "⛔ Enter valid password(Minimum 8 characters)";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          newPasswordEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          hintText: '##########',
                          hintStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0XFF595550),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0XFF595550),
                            ),
                            splashColor: Colors.transparent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(37.0, 27.0, 0.0, 8.0),
                      child: Text(
                        'New Password Again',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: newPasswordAgainEditingController,
                        keyboardType: TextInputType.text,
                        obscureText: _isVisible,
                        obscuringCharacter: '#',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{8,}$');
                          if (value!.isEmpty) {
                            return "⛔ This field is required";
                          }
                          if (!regex.hasMatch(value)) {
                            return "⛔ Enter valid password(Minimum 8 characters)";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          newPasswordAgainEditingController.text = newValue!;
                        },
                        cursorColor: const Color(0XFF2A2B2E),
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0XFF595550),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0XFFFFFDFA),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          hintText: '##########',
                          hintStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0XFF595550),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0XFF595550),
                            ),
                            splashColor: Colors.transparent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFFFFDFA)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(36.0, 45.0, 36.0, 90.0),
                      child: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).highlightColor,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Color(0XFFFFFDFA),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    Get.bottomSheet(
      Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.zero, top: Radius.circular(32.0)),
            color: Theme.of(context).highlightColor,
          ),
          child: Column(
            children: [
              MaterialButton(
                height: 60.0,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  //takePhoto(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/camera.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 18.0, 0.0, 0.0),
                      child: const Text(
                        'Camera',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                height: 60.0,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/image.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 0.0, 0.0),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  // void takePhoto(ImageSource source) async {
  //   final PickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _imageFile = PickedFile!;
  //   });
  // }

}
