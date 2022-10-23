import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notely/passwordreset.dart';
import 'package:notely/startseite.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();

  bool _isVisible = true;
  /*
  bool _isChecked = false;
  late Box box1;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('signData');
    getData();
  }

  void getData() {
    if (box1.get('email') != null) {
      emailEditingController.text = box1.get('email');
      _isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      passwordEditingController.text = box1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0XFFA3333D),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 48.0),
                  child: const Text(
                    'NOTELY',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                      color: Color(0XFFEAEAEA),
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
                  margin: const EdgeInsets.fromLTRB(2.0, 20.0, 0.0, 8.0),
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
                        return "⛔ This field is required";
                      }
                      if (!regex.hasMatch(value)) {
                        return "⛔ Enter valid password(Minimum 8 characters)";
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
                /*
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor:  const Color(0XFFA3333D),
                          value: _isChecked,
                          onChanged: (value) async {
                            _isChecked = !_isChecked;
                            setState(() {});
                          }
                      ),
                      const Text(
                        'Keep me logged in',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0XFFEAEAEA),
                        ),
                      ),
                    ],
                  ),
                ),
                */
                Container(
                  width: 340,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 46.0, 0.0, 0.0),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color(0XFFA3333D),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 54,
                      onPressed: () {
                        login(emailEditingController.text,
                            passwordEditingController.text);
                        //_getData();
                      },
                      child: const Text(
                        'Login',
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
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 0.0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(const PasswordReset());
                    },
                    child: const Text(
                      'Forgot Password?',
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

  void login(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((email) async => {
                Fluttertoast.showToast(
                  msg: "Login succesfully :) ",
                  backgroundColor: const Color(0XFFA3333D),
                  textColor: Colors.white,
                  fontSize: 14.0,
                ),
                Get.to(const StartSeite())
              })
          .catchError((e) {
        Fluttertoast.showToast(
          msg: "Sorry, you couldn't not log in. Please check your information.",
          backgroundColor: const Color(0XFFA3333D),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      });
    }
  }
  /*
  void _getData() {
    if (_isChecked) {
      box1.put('email', emailEditingController.text);
      box1.put('password', passwordEditingController.text);
    } else {
      box1.put('email', null);
      box1.put('password', null);
    }
  }
  */
}
