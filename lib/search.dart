import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/addnote.dart';
import 'package:notely/startseite.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final getStorage = GetStorage();
  static bool selected = true;
  static bool search = false;
  late String searchKey;
  late Stream streamQuery;

  @override
  void initState() {
    getNotes();
    getStorage.read("isSelected");
    print(getStorage.read("isSelected"));
    print(selected);
    print(getSearchData());
    super.initState();
  }

  void getNotes() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("Notes");
    var querySnapshot = await collection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = querySnapshot.docs;
    var notes = data;
    setState(() {
      if (notes.isEmpty) {
        getStorage.write("notes", "false");
      } else {
        getStorage.write("notes", "true");
      }
      print(notes);
      print(getStorage.read("notes"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          onPressed: () {
            Get.to(const StartSeite());
          },
          splashRadius: 25.0,
        ),
        title: Container(
          alignment: Alignment.center,
          height: 30,
          child: TextFormField(
            autofocus: false,
            controller: searchEditingController,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                searchKey = value;
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
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                width: 8,
                height: 8,
                child: SvgPicture.asset('assets/images/search2.svg',
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
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  alignment: Alignment.centerLeft,
                  width: 8,
                  height: 8,
                  child: const Icon(Icons.close, color: Color(0XFF2A2B2E))),
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
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: Scrollbar(
          controller: _scrollController,
          thickness: 5,
          radius: const Radius.circular(20.0),
          scrollbarOrientation: ScrollbarOrientation.right,
          child: SingleChildScrollView(
            controller: _scrollController,
            /*child: StreamBuilder(
              stream: getSearchData(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) 
                return ListView.builder(
                  itemBuilder: ((BuildContext context, index) => ));
              }
            ),*/
          ),
        ),
      ),
    );
  }
}

getSearchData() async {
  var data = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.email)
      .collection('Notes')
      .where("note", isLessThanOrEqualTo: DateTime.now())
      .orderBy("note")
      .get();
  return data.docs;
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
                  
                      getStorage.write("newNote", false);
                      getStorage.write("noteId", widget.noteId);
                      getStorage.write("title", widget.title);
                      getStorage.write("note", widget.note);
                      Get.to(const AddNote());
                    });
                  
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
} 

class showListNotes extends StatefulWidget {
  String title, note, noteId;

  showListNotes({
    Key? key,
    required this.title,
    required this.note,
    required this.noteId,
  }) : super(key: key);

  @override
  State<showListNotes> createState() => _showListNotesState();
}

class _showListNotesState extends State<showListNotes> {
  final getStorage = GetStorage();

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
                  getStorage.write("newNote", false);
                  getStorage.write("noteId", widget.noteId);
                  getStorage.write("title", widget.title);
                  getStorage.write("note", widget.note);
                  Get.to(const AddNote());
                });
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                primary: Theme.of(context).textSelectionTheme.selectionColor,
                side: BorderSide(
                  color: Theme.of(context).backgroundColor ==
                              const Color(0XFFEAEAEA)
                          ? const Color(0XFF2A2B2E)
                          : const Color(0XFFEAEAEA),
                  width: 1.0,
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
}
