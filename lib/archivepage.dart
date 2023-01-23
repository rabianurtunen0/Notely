import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notely/labels.dart';
import 'package:notely/setting.dart';
import 'package:notely/startseite.dart';
import 'package:notely/trashpage.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final searchEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final getStorage = GetStorage();
  bool search = false;

  String isSelected = "false";

  callback(newIsSelected) {
    setState(() {
      isSelected = newIsSelected;
    });
  }

  @override
  void initState() {
    getNotes();
    setState(() {
      print(getStorage.read("isSelected"));
    });
    getStorage.write("search", "false");
    super.initState();
  }

  void getNotes() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("Archive");
    var querySnapshot = await collection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = querySnapshot.docs;
    var notes = data;
    setState(() {
      if (notes.isEmpty) {
        getStorage.write("archive", "false");
      } else {
        getStorage.write("archive", "true");
      }
      print(notes);
      print(getStorage.read("archive"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/images/menu.svg',
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              splashRadius: 25.0,
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'Archive',
          style: TextStyle(
            fontFamily: 'Titan One',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/search.svg',
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onPressed: () {
                setState(() {
                  getStorage.read("search") == 'true'
                      ? getStorage.write("search", "false")
                      : getStorage.write("search", "true");
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset(
                getStorage.read("changeView") == 'true'
                    ? 'assets/images/category.svg'
                    : 'assets/images/frame.svg',
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              splashRadius: 25.0,
              onPressed: () {
                setState(() {
                  getStorage.read("changeView") == 'true'
                      ? getStorage.write("changeView", "false")
                      : getStorage.write("changeView", "true");
                });
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: getStorage.read("changeColor")
            ? const Color(0XFFA3333D)
            : const Color(0XFF613DC1),
        width: 310,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.zero, right: Radius.circular(32.0)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(36.0, 54.0, 0.0, 27.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'NOTELY',
                style: TextStyle(
                  fontFamily: 'Titan One',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0XFFFFFDFA),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: MaterialButton(
                onPressed: () => Get.to(const StartSeite()),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/notes.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Notes',
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: MaterialButton(
                onPressed: () => Get.to(const Labels()),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/label.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                      child: Text(
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: MaterialButton(
                onPressed: () => Get.to(const Trash()),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/trash.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Trash',
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: MaterialButton(
                onPressed: () => Get.to(const Archive()),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/archive.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                      child: Text(
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: MaterialButton(
                onPressed: () => Get.to(const Setting()),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: SvgPicture.asset(
                        'assets/images/settings.svg',
                        color: const Color(0XFFFFFDFA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Settings',
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
            ),
          ],
        ),
      ),
      floatingActionButton: isSelected == "true"
          ? Container(
              width: 260,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    getStorage.write('isSelected', false);
                    if (getStorage.read('isSelected') == "false") {}
                  });
                },
                backgroundColor: getStorage.read("changeColor")
                    ? const Color(0XFFA3333D)
                    : const Color(0XFF613DC1),
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Row(
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () {
                          exitArchive();
                        },
                        child: SvgPicture.asset(
                          "assets/images/exit_archive.svg",
                          color: const Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          delete();
                        },
                        child: SvgPicture.asset(
                          "assets/images/trash.svg",
                          color: const Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          "assets/images/checkall.svg",
                          color: const Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          isSelected = "false";
                          callback(isSelected);
                        },
                        child: const Icon(
                          size: 28,
                          Icons.close,
                          color: Color(0XFFFFFDFA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Container(
        height: 2500,
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        color: Theme.of(context).backgroundColor,
        child: Scrollbar(
          controller: _scrollController,
          thickness: 5,
          radius: const Radius.circular(20.0),
          scrollbarOrientation: ScrollbarOrientation.right,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                getStorage.read("search") == 'true'
                    ? Container(
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        alignment: Alignment.center,
                        height: 30,
                        child: TextFormField(
                          autofocus: false,
                          controller: searchEditingController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              var searchKey = value;
                              getStorage.write("searchKey", value);
                            });
                          },
                          onSaved: (newValue) {
                            searchEditingController.text = newValue!;
                          },
                          cursorColor: const Color(0XFF2A2B2E),
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0XFF2A2B2E)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0XFFFFFDFA),
                            prefixIcon: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 0.0, 0.0),
                              alignment: Alignment.centerLeft,
                              width: 8,
                              height: 8,
                              child: SvgPicture.asset(
                                  'assets/images/search2.svg',
                                  color: const Color(0XFF2A2B2E)),
                            ),
                            hintText: 'Search in notes',
                            hintStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0XFF595550),
                            ),
                            suffixIcon: Container(
                                margin: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 0.0, 0.0),
                                alignment: Alignment.centerLeft,
                                width: 8,
                                height: 8,
                                child: const Icon(Icons.close,
                                    color: Color(0XFF2A2B2E))),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0XFFFFFDFA),
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0XFFFFFDFA),
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        height: 0,
                      ),
                Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  color: Theme.of(context).backgroundColor,
                  child: getStorage.read("archive") == 'true'
                      ? getStorage.read("changeView") == 'true'
                          ? Container(
                              alignment: Alignment.topCenter,
                              color: Theme.of(context).backgroundColor,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth
                                        .instance.currentUser?.email)
                                    .collection('Archive')
                                    .orderBy('date', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return StaggeredGridView.countBuilder(
                                      controller: _scrollController,
                                      itemCount: snapshot.data?.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot documentData =
                                            snapshot.data!.docs[index];
                                        return showNotes(
                                          title: documentData["title"],
                                          note: documentData["note"],
                                          noteId: documentData["noteId"],
                                          isSelected: isSelected,
                                          callback: callback,
                                        );
                                      },
                                      crossAxisCount: 2,
                                      staggeredTileBuilder: (int index) =>
                                          const StaggeredTile.fit(1),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )
                          : Container(
                              alignment: Alignment.topCenter,
                              color: Theme.of(context).backgroundColor,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth
                                        .instance.currentUser?.email)
                                    .collection('Archive')
                                    .orderBy('date', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      controller: _scrollController,
                                      itemCount: snapshot.data?.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot documentData =
                                            snapshot.data!.docs[index];
                                        print(snapshot.data!.docs[index]);
                                        return showNotes(
                                          title: documentData["title"],
                                          note: documentData["note"],
                                          noteId: documentData["noteId"],
                                          isSelected: isSelected,
                                          callback: callback,
                                        );
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 35.0, horizontal: 10.0),
                          alignment: Alignment.center,
                          transformAlignment: Alignment.center,
                          child: SvgPicture.asset(getStorage.read("changeColor")
                              ? 'assets/images/archive_picture1.svg'
                              : "assets/images/archive_picture2.svg"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    var box = Hive.box('getList_archive');
    for (var i = 0; i < box.get("_getList_archive").length; i++) {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Archive')
          .doc(box.get("_getList_archive")[i][0]);
      var querySnapshot = await collection.get();
      Map<String, dynamic>? data = querySnapshot.data();
      var noteId = data!['noteId'];
      var date = data['date'];
      var title = data['title'];
      var note = data['note'];
      setState(() {
        print([noteId, date, title, note]);
      });
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Archive")
          .doc(box.get("_getList_archive")[i][0])
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
          .doc(box.get("_getList_archive")[i][0])
          .set({
        'noteId': noteId,
        'title': title,
        'note': note,
        'date': date,
      });
    }
    getStorage.write("isSelected", false);
    Get.to(const Archive());
    Fluttertoast.showToast(
      msg: "Your notes or note has been archived",
      backgroundColor: getStorage.read("changeColor")
          ? const Color(0XFFA3333D)
          : const Color(0XFF613DC1),
      textColor: const Color(0XFFFFFDFA),
      fontSize: 14.0,
      timeInSecForIosWeb: 2,
    );
  }

  void exitArchive() async {
    var box = Hive.box('getList_archive');
    for (var i = 0; i < box.get("_getList_archive").length; i++) {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Archive')
          .doc(box.get("_getList_archive")[i][0]);
      var querySnapshot = await collection.get();
      Map<String, dynamic>? data = querySnapshot.data();
      var noteId = data!['noteId'];
      var date = data['date'];
      var title = data['title'];
      var note = data['note'];
      setState(() {
        print([noteId, date, title, note]);
      });
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection("Archive")
          .doc(box.get("_getList_archive")[i][0])
          .delete();
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
          .doc(box.get("_getList_archive")[i][0])
          .set({
        'noteId': noteId,
        'title': title,
        'note': note,
        'date': date,
      });
    }
    getStorage.write("isSelected", false);
    Get.to(const Archive());
    Fluttertoast.showToast(
      msg: "Your notes or note has been archived",
      backgroundColor: getStorage.read("changeColor")
          ? const Color(0XFFA3333D)
          : const Color(0XFF613DC1),
      textColor: const Color(0XFFFFFDFA),
      fontSize: 14.0,
      timeInSecForIosWeb: 2,
    );
  }
}

class showNotes extends StatefulWidget {
  String title, note, noteId;
  String isSelected;
  Function(String) callback;

  showNotes({
    Key? key,
    required this.title,
    required this.note,
    required this.noteId,
    required this.isSelected,
    required this.callback,
  }) : super(key: key);

  @override
  State<showNotes> createState() => _showNotesState();
}

class _showNotesState extends State<showNotes> {
  final getStorage = GetStorage();
  var isSelected = false;
  static int selected = 0;
  static List<dynamic> list_archive = [];

  void _hive() async {
    await Hive.initFlutter();
    var box = await Hive.openBox('getList_archive');
    var initialList = list_archive;
    box.put('_getList_archive', initialList);
    var list = box.get('_getList_archive');
    print("....................");
    print(initialList);
  }

  @override
  void initState() {
    setState(() {
      _hive();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: getStorage.read("changeView") == "false"
          ? const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0)
          : const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 7.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            width: MediaQuery.of(context).size.width,
            constraints: const BoxConstraints(),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  if (getStorage.read("isSelected").toString() == "true") {
                    if (isSelected == true) {
                      isSelected = false;
                      selected--;
                      int selectNote = 0;
                      for (var note in list_archive) {
                        if (note[0] == widget.noteId) {
                          selectNote = list_archive.indexOf(note);
                        }
                      }
                      list_archive.removeAt(selectNote);
                      _hive();
                      widget.callback("true");
                    } else {
                      isSelected = true;
                      selected++;
                      list_archive.add([widget.noteId, widget.title, widget.note]);
                      _hive();
                      widget.callback("true");
                    }
                    if (selected == 0) {
                      getStorage.write("isSelected", false);
                      list_archive.clear();
                      _hive();
                      widget.callback("false");
                    }
                  }
                });
              },
              onLongPress: () {
                toogleSelection();
                _hive();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                primary: Theme.of(context).textSelectionTheme.selectionColor,
                side: BorderSide(
                  color: isSelected
                      ? getStorage.read("changeColor")
                          ? const Color(0XFFA3333D)
                          : const Color(0XFF613DC1)
                      : Theme.of(context).backgroundColor ==
                              const Color(0XFFEAEAEA)
                          ? const Color(0XFF2A2B2E)
                          : const Color(0XFFEAEAEA),
                  width: getStorage.read("changeView") == "false"
                      ? isSelected
                          ? 2.0
                          : 1.0
                      : 1.0,
                ),
                backgroundColor: Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 4.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.note,
                      textAlign: TextAlign.left,
                      maxLines:
                          getStorage.read("changeView") == "false" ? 1 : null,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      overflow: getStorage.read("changeView") == "false"
                          ? TextOverflow.ellipsis
                          : null,
                    ),
                  ),
                  Text(
                    widget.noteId,
                    style: const TextStyle(fontSize: 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toogleSelection() {
    setState(() {
      if (isSelected) {
        isSelected = false;
        selected--;
        int selectNote = 0;
        for (var note in list_archive) {
          if (note[0] == widget.noteId) {
            selectNote = list_archive.indexOf(note);
          }
        }
        list_archive.removeAt(selectNote);
        widget.callback("true");
        if (selected == 0) {
          getStorage.write("isSelected", false);
          list_archive.clear();
          widget.callback("false");
        }
      } else {
        isSelected = true;
        selected++;
        getStorage.write("isSelected", true);
        list_archive.add([widget.noteId, widget.title, widget.note]);
        widget.callback("true");
      }
    });
  }
}
