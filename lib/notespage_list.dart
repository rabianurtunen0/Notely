import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/addnote.dart';
import 'package:notely/startseite.dart';

class NotesPageList extends StatefulWidget {
  final VoidCallback? voidCallback;
  const NotesPageList({Key? key, this.voidCallback}) : super(key: key);

  @override
  State<NotesPageList> createState() => _NotesPageListState();
}

class _NotesPageListState extends State<NotesPageList> {
  //final VoidCallback voidCallback; _NotesPageListState({this.voidCallback});
  final _scrollController = ScrollController();
  final searchEditingController = TextEditingController();
  final getStorage = GetStorage();

  List<String> getList() {
    List<String> listData = [];

    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Notes')
        .where('noteId')
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listData.add(doc["noteId"]);
      });
    });

    return listData;
  }

  @override
  void initState() {
    getList();
    print(getList());
    super.initState();
  }

  var search = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.email)
                .collection('Notes')
                .orderBy('date', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentData = snapshot.data!.docs[index];
                    print(snapshot.data!.docs[index]);
                    return showNotes(
                      title: documentData["title"],
                      note: documentData["note"],
                      noteId: documentData["noteId"],
                    );
                  },
                  
                );
              }
              if (snapshot.hasData && search == true) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(getStorage.read("isSelected"));
                    DocumentSnapshot documentData = snapshot.data!.docs[index];
                    return showNotes(
                      title: documentData["title"],
                      note: documentData["note"],
                      noteId: documentData["noteId"],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class showNotes extends StatefulWidget {
  String title, note, noteId;

  showNotes({
    Key? key,
    required this.title,
    required this.note,
    required this.noteId,
  }) : super(key: key);

  @override
  State<showNotes> createState() => _showNotesState();
}

class _showNotesState extends State<showNotes> {
  final getStorage = GetStorage();
  var isSelected = false;
  static int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
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
                      print(selected);
                    } else {
                      isSelected = true;
                      selected++;
                      print(selected);
                    }
                    if (selected == 0) {
                      getStorage.write("isSelected", false);
                      //isSelected = false;
                    }
                  } else {
                    setState(() {
                      getStorage.write("newNote", false);
                      getStorage.write("noteId", widget.noteId);
                      getStorage.write("title", widget.title);
                      getStorage.write("note", widget.note);
                      Get.to(const AddNote());
                    });
                  }
                });
              },
              onLongPress: () {
                toogleSelection();
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
                  width: isSelected ? 2.0 : 1.0,
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
                      maxLines: 1,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
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
        if (selected == 0) {
          getStorage.write("isSelected", false);
        }
      } else {
        isSelected = true;
        selected++;
        getStorage.write("isSelected", true);
      }
    });
  }
}
