import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/startseite.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleEditingController = TextEditingController();
  final noteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(const StartSeite());
            createNotes();
          },
          icon: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          splashRadius: 25.0,
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Edit Note',
            style: TextStyle(
              fontFamily: 'Titan One',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                bottomSheet();
              },
              icon: SvgPicture.asset(
                'assets/images/more.svg',
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              splashRadius: 25.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: TextField(
                controller: titleEditingController,
                maxLines: 1,
                cursorColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: "Title..",
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 0.0),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: noteEditingController,
                onEditingComplete: () => createNotes(),
                maxLines: 24,
                cursorColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  letterSpacing: 1,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: "Note..",
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet() {
    Get.bottomSheet(
      Container(
          height: 330.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.zero, top: Radius.circular(32.0)),
            color: Theme.of(context).highlightColor,
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/delete_note.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                      child: const Text(
                        'Delete note',
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/copy.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                      child: const Text(
                        'Make a copy',
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/share.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                      child: const Text(
                        'Share',
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/label.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                      child: const Text(
                        'Labels',
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/archive.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 0.0, 0.0),
                      child: const Text(
                        'Archive',
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
            ],
          )),
    );
  }

  void createNotes() async {
    if (titleEditingController.text.isNotEmpty ||
        noteEditingController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Notes')
          .doc()
          .set({
        'title': titleEditingController.text,
        'note': noteEditingController.text,
        'date': DateTime.now(),
      });
    }
  }
}
