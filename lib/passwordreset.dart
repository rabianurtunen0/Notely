import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:notely/login.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final emailEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.to(const Login()),
          icon: ImageIcon(
             const AssetImage('assets/images/arrow_left.png'),
            color: Theme.of(context).highlightColor,
          ),
          splashRadius: 25.0,
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
                  margin: const EdgeInsets.fromLTRB(0.0, 82.0, 0.0, 88.0),
                  child: Text(
                    'NOTELY',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                      color: Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 8.0),
                  child: Text(
                    'Email Address',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Theme.of(context).textSelectionTheme.selectionColor,
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
                  width: 340,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0.0, 46, 0.0, 0.0),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).highlightColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        resetPassword();
                      },
                      child: const Text(
                        'Send Reset Link',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color(0XFFFFFDFA),
                          letterSpacing: 1.5,
                          wordSpacing: 1.5,
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
                      Get.to(const Login());
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).backgroundColor),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
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

  void resetPassword() async {
    if (_fromKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(
            email: emailEditingController.text.trim());
        Fluttertoast.showToast(
          msg: "Password reset email sent",
          // ignore: use_build_context_synchronously
          backgroundColor: Theme.of(context).highlightColor, 
          textColor: const Color(0XFFFFFDFA),
          fontSize: 14.0,
        );
        Get.to(const Login());
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          backgroundColor: Theme.of(context).highlightColor, 
          textColor: const Color(0XFFFFFDFA),
          fontSize: 14.0,
        );
      }
    }
  }
}
