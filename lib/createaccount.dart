import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:notely/login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final fullNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 52.0),
                  child: const Text(
                    'NOTELY',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0XFFEAEAEA),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                  child: const Text(
                    'Create a free account',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Color(0XFFEAEAEA),
                      wordSpacing: 1.5,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 52.0),
                  child: const Text(
                    'Join Notely for free. Create and share unlimited notes with your friends.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0XFFD9D9D9),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 8.0),
                  child: const Text(
                    'Full Name',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0XFFFFFDFA),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: false,
                    controller: fullNameEditingController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "??? This field is required";
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
                      hintText: 'Full Name',
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0XFF595550),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(2.0, 20.0, 0.0, 8.0),
                  child: const Text(
                    'Email Address',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0XFFFFFDFA),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: false,
                    controller: emailEditingController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "??? This field is required";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "??? Please enter a valid email adress";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      emailEditingController.text = newValue!;
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
                      hintText: 'name@example.com',
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0XFF595550),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 8.0),
                  child: const Text(
                    'Password',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0XFFFFFDFA),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: false,
                    controller: passwordEditingController,
                    keyboardType: TextInputType.text,
                    obscureText: _isVisible,
                    obscuringCharacter: '#',
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{8,}$');
                      if (value!.isEmpty) {
                        return "??? This field is required";
                      }
                      if (!regex.hasMatch(value)) {
                        return "??? Enter valid password(Minimum 8 characters)";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      passwordEditingController.text = newValue!;
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
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFFF2E5D5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 340,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 46.0, 0.0, 0.0),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).primaryColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 54,
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color(0XFFFFFDFA),
                          letterSpacing: 1.5,
                          wordSpacing: 1.5,
                        ),
                      ),
                      onPressed: () => createAccount(
                          emailEditingController.text,
                          passwordEditingController.text),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 0.0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(const Login());
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Color(0XFFEAEAEA),
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

  void createAccount(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => {
                await _firestore.collection('Users').doc(email).set({
                  'fullname': fullNameEditingController.text,
                  'email': email,
                  'password': password,
                }),
                Fluttertoast.showToast(
                  msg: "Account created succesfully :) ",
                  backgroundColor: const Color(0XFFA3333D),
                  textColor: Colors.white,
                  fontSize: 14.0,
                ),
                Get.to(const Login())
              })
          .catchError((e) {
        Fluttertoast.showToast(
          msg: e!.message,
          backgroundColor: const Color(0XFFA3333D),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      });
    }
  }
}