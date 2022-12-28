import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/setting.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final getStorage = GetStorage();
  final _scrollController = ScrollController();
  final _fromKey = GlobalKey<FormState>();

  bool loading = false;
  bool _isVisible = true;

  @override
  void initState() {
    print(_image);
    super.initState();
  }

  late final fullNameEditingController =
      TextEditingController(text: getStorage.read("fullname").toString());
  final emailEditingController =
      TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
  late final locationEditingController =
      TextEditingController(text: getStorage.read("location"));

  final oldPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();
  final newPasswordAgainEditingController = TextEditingController();

  File? _image;

  Future getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  Future getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  // Uint8List imgbytes = await _image!.readAsBytes();
  // String imageBs4str = base64.encode(imgbytes);
  // print(imageBs4str);

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
                      child: _image != null
                          ? CircleAvatar(
                              radius: 75.0,
                              backgroundColor: Colors.black,
                              backgroundImage: Image.file(
                                _image!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ).image,
                            )
                          : CircleAvatar(
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
                          hintText:
                              getStorage.read("location").toString() == "null"
                                  ? "Enter location.."
                                  : getStorage.read("loaction"),
                          hintStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0XFF595550),
                          ),
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
                          if (newPasswordEditingController.text.isNotEmpty &&
                              newPasswordEditingController.text.length < 8) {
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
                          if (newPasswordEditingController.text !=
                              newPasswordAgainEditingController.text) {
                            return "⛔ Password don't match";
                          }
                          if (newPasswordAgainEditingController.text.isNotEmpty &&
                              newPasswordAgainEditingController.text.length < 8) {
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
                        color: getStorage.read("changeColor")
                            ? const Color(0XFFA3333D)
                            : const Color(0XFF613DC1),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () {
                            setState(() {
                              loading = true;
                              //oldPasswordEditingController.text == FirebaseAuth.instance.currentUser.
                              updateData();
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                loading = false;
                              });
                            });
                          },
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Color(0XFFFFFDFA),
                                  strokeWidth: 2.0,
                                )
                              : const Text(
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
        height: 250.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.zero, top: Radius.circular(32.0)),
          color: getStorage.read("changeColor")
              ? const Color(0XFFA3333D)
              : const Color(0XFF613DC1),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
              child: SvgPicture.asset(
                'assets/images/line.svg',
                color: const Color(0XFFFFFDFA),
              ),
            ),
            MaterialButton(
              height: 60.0,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                getImageCamera();
                print(getImageCamera());
                print(_image);
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/images/camera.svg',
                      color: const Color(0XFFFFFDFA),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
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
              onPressed: () {
                getImageGallery();
                print(_image);
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/images/image.svg',
                      color: const Color(0XFFFFFDFA),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
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
            ),
            MaterialButton(
              height: 60.0,
              splashColor: Colors.transparent,
              onPressed: () {},
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/images/trash.svg',
                      color: const Color(0XFFFFFDFA),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                    child: const Text(
                      'Delete photo',
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
        ),
      ),
    );
  }

  void updateData() async {
    if (_fromKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email.toString(),
          password: oldPasswordEditingController.text);

      user.reauthenticateWithCredential(cred).then((value) {
        user
            .updatePassword(newPasswordEditingController.text)
            .then((_) {
              Fluttertoast.showToast(
                msg: "Your information has been successfully changed",
                backgroundColor: getStorage.read("changeColor")
                    ? const Color(0XFFA3333D)
                    : const Color(0XFF613DC1),
                textColor: const Color(0XFFFFFDFA),
                fontSize: 14.0,
              );
            })
            .catchError((error) {
              print("Error " + error.toString());
            });
      }).catchError((e) {
        Fluttertoast.showToast(
                msg: e.message,
                backgroundColor: getStorage.read("changeColor")
                    ? const Color(0XFFA3333D)
                    : const Color(0XFF613DC1),
                textColor: const Color(0XFFFFFDFA),
                fontSize: 14.0,
              );
      });
      await _auth.currentUser!.updateEmail(emailEditingController.text);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        'email': emailEditingController.text,
        'fullname': fullNameEditingController.text,
        //'profilepicture': imageBs4str.toString(),
        'location': locationEditingController.text.isEmpty
            ? null
            : locationEditingController.text,
      }).then((value) => {
                Fluttertoast.showToast(
                  msg: "Your information has been successfully changed",
                  backgroundColor: getStorage.read("changeColor")
                      ? const Color(0XFFA3333D)
                      : const Color(0XFF613DC1),
                  textColor: const Color(0XFFFFFDFA),
                  fontSize: 14.0,
                ),
              });
      
      Get.to(const EditProfile());
    }
  }
}
