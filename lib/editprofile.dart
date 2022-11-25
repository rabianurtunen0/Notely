import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/settings.dart';
//import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _fromKey = GlobalKey<FormState>();
  final fullNameEditingController =
      TextEditingController(text: 'Rabia Nur Tünen');
  final emailEditingController =
      TextEditingController(text: 'rrabianurtunen@gmail.com');
  final locationEditingController =
      TextEditingController(text: 'Konya, Turkey');
  final oldPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();
  final newPasswordAgainEditingController = TextEditingController();

  final _scrollController = ScrollController();
  bool _isVisible = true;

  //PickedFile _imageFile;
  //final ImagePicker _picker = ImagePicker();

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
          onPressed: () => Get.to(const Settings()),
          icon: ImageIcon(
            const AssetImage('assets/images/arrow_left.png'),
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
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/people.png'),
                        radius: 75.0,
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
                      margin: const EdgeInsets.fromLTRB(31.0, 45.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      margin: const EdgeInsets.fromLTRB(31.0, 27.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      margin: const EdgeInsets.fromLTRB(31.0, 27.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      margin: const EdgeInsets.fromLTRB(31.0, 0.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      margin: const EdgeInsets.fromLTRB(31.0, 27.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      margin: const EdgeInsets.fromLTRB(31.0, 27.0, 0.0, 8.0),
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
                      padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
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
                                const BorderSide(color: Color(0XFFF2E5D5)),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0XFFF2E5D5)),
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
                      width: 340,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 90.0),
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
          height: 120.0,
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
                      child: const ImageIcon(
                        AssetImage('assets/images/camera.png'),
                        color: Color(0XFFFFFDFA),
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
                      child: const ImageIcon(
                        AssetImage('assets/images/image.png'),
                        color: Color(0XFFFFFDFA),
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
