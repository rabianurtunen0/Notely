import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/addnote.dart';

class ArchivePageGrid extends StatefulWidget {
  const ArchivePageGrid({Key? key}) : super(key: key);

  @override
  State<ArchivePageGrid> createState() => _ArchivePageGridState();
}

class _ArchivePageGridState extends State<ArchivePageGrid> {
  final _scrollController = ScrollController();
  final searchEditingController = TextEditingController();
  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.email)
                .collection('Archive')
                .orderBy('date', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentData = snapshot.data!.docs[index];
                    return showGridNotes(
                      title: documentData["title"],
                      note: documentData["note"],
                      noteId: documentData["noteId"],

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
          )
        ],
      ),
    );
  }
}







class showGridNotes extends StatefulWidget {
  String title, note, noteId;

  showGridNotes({
    Key? key,
    required this.title,
    required this.note,
    required this.noteId,
  }) : super(key: key);

  @override
  State<showGridNotes> createState() => _showGridNotesState();
}

class _showGridNotesState extends State<showGridNotes> {
  final getStorage = GetStorage();
  var isSelected = false;
  static int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 7.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
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
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 2.0),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 4.0),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      widget.note,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      //overflow: TextOverflow.ellipsis,
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
