import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/startseite.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final getStorage = GetStorage();
  final _fromKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  late final titleEditingController = TextEditingController(
      text: getStorage.read("newNote").toString() == "true"
          ? null
          : getStorage.read("title").toString());

  late final noteEditingController = TextEditingController(
      text: getStorage.read("newNote").toString() == "true"
          ? null
          : getStorage.read("note").toString());

  @override
  void initState() {
    delete30();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getStorage.read("newNote").toString() == "true"
            ? createNote()
            : changeNote();
        Get.to(const StartSeite());
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              getStorage.read("newNote").toString() == "true"
                  ? createNote()
                  : changeNote();
              Get.to(const StartSeite());
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
        body: Form(
          key: _fromKey,
          child: Scrollbar(
            controller: _scrollController,
            thickness: 5,
            radius: const Radius.circular(20.0),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      child: TextField(
                        controller: titleEditingController,
                        maxLines: 1,
                        inputFormatters: [LengthLimitingTextInputFormatter(24)],
                        cursorColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "Title..",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: noteEditingController,
                        minLines: 20,
                        maxLines: 1000,
                        cursorColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          letterSpacing: 1,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "Note..",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            letterSpacing: 1,
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
          height: 270,
          //height: 330.0,
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  getStorage.read("newNote").toString() == "true"
                      ? createNote()
                      : changeNote();
                  delete();
                },
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
              /*MaterialButton(
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
              ),*/
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  getStorage.read("newNote").toString() == "true"
                      ? createNote()
                      : changeNote();
                  archive();
                },
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

  void createNote() async {
    if (titleEditingController.text.isNotEmpty ||
        noteEditingController.text.isNotEmpty) {
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Notes")
          .doc();
      var querySnapshots = await documentRef.get();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Notes')
          .doc(querySnapshots.id)
          .set({
        'title': titleEditingController.text,
        'note': noteEditingController.text,
        'date': DateTime.now(),
        'noteId': querySnapshots.id,
      });
      getStorage.write("noteId", querySnapshots.id);
      getStorage.write("date", DateTime.now());
      getStorage.write("title", titleEditingController.text);
      getStorage.write("note", noteEditingController.text);
    }
  }

  void changeNote() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc(getStorage.read("noteId"))
        .update({
      "title": titleEditingController.text,
      "note": noteEditingController.text,
    });
    getStorage.write("title", titleEditingController.text);
    getStorage.write("note", noteEditingController.text);
    if (titleEditingController.text.isEmpty &&
        noteEditingController.text.isEmpty) {}
  }

  void archive() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc(getStorage.read("noteId"));
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    var noteId = data!['noteId'];
    var date = data['date'];
    var title = data['title'];
    var note = data['note'];
    setState(() {
      print([noteId, date, title, note]);
    });
    if (titleEditingController.text.isNotEmpty ||
        noteEditingController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Notes")
          .doc(getStorage.read("noteId").toString())
          .delete();
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Archive")
          .doc();
      var querySnapshots = await documentRef.get();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Archive')
          .doc(querySnapshots.id)
          .set({
        'title': titleEditingController.text,
        'note': noteEditingController.text,
        'date': DateTime.now(),
        'noteId': querySnapshots.id,
      });
    }
  }

  void delete() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .doc(getStorage.read("noteId"));
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    var noteId = data!['noteId'];
    var date = data['date'];
    var title = data['title'];
    var note = data['note'];
    setState(() {
      print([
        noteId,
        date,
        /*DateTime.fromMillisecondsSinceEpoch(date),*/ 
        title,
        note
      ]);
    });
    if (titleEditingController.text.isNotEmpty ||
        noteEditingController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Notes")
          .doc(getStorage.read("noteId").toString())
          .delete();
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Trash")
          .doc();
      var querySnapshots = await documentRef.get();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Trash')
          .doc(querySnapshots.id)
          .set({
        'title': titleEditingController.text,
        'note': noteEditingController.text,
        'date': DateTime.now(),
        'noteId': querySnapshots.id,
      });
    }
  }

  void delete30() {
    var now = DateTime.now();    
    var now2 = 30*24*60*60*1000;

    
    print(now);
    //var lastMonth = now - (30 * 24 * 60 * 60 * 1000);
  }
}
