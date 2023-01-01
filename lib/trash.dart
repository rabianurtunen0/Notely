import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/archive.dart';
import 'package:notely/setting.dart';
import 'package:notely/startseite.dart';
import 'package:notely/trashpage_grid.dart';
import 'package:notely/trashpage_list.dart';

class Trash extends StatefulWidget {
  const Trash({Key? key}) : super(key: key);

  @override
  State<Trash> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  final searchEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final getStorage = GetStorage();
  static bool selected = true;
  bool search = false;

  @override
  void initState() {
    getNotes();
    getStorage.read("isSelected");
    print(getStorage.read("isSelected"));
    print(selected);
    print(getStorage.listen(
      () {
        print(getStorage.read("isSelected"));
      },
    ));
    getStorage.write("search", "false");
    super.initState();
  }

  void getNotes() async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("Trash");
    var querySnapshot = await collection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = querySnapshot.docs;
    var notes = data;
    setState(() {
      if (notes.isEmpty) {
        getStorage.write("trash", "false");
      } else {
        getStorage.write("trash", "true");
      }
      print(notes);
      print(getStorage.read("trash"));
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
          'Trash',
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
                'assets/images/search2.svg',
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
            /*Container(
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
            ),*/
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
      floatingActionButton: getStorage.read("isSelected")
          ? Container(
              width: 320,
              child: FloatingActionButton(
                onPressed: () {},
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
                          onPressed: () {},
                          child: SvgPicture.asset(
                            "assets/images/share.svg",
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          )),
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {},
                          child: SvgPicture.asset(
                            "assets/images/archive.svg",
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          )),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          "assets/images/trash.svg",
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: TextButton(
                          onPressed: () {},
                          child: SvgPicture.asset(
                            "assets/images/checkall.svg",
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          )),
                    ),
                    Container(
                      
                      child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            size: 28,
                            Icons.close,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,),
                           
                          ),
                    ),
                  ],
                ),
                
              ),
              
            )
            
          : null, 
      body: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
                    child: getStorage.read("trash") == 'true'
                        ? getStorage.read("changeView") == 'true'
                            ? const TrashPageGrid()
                            : const TrashPageList()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 10.0),
                            alignment: Alignment.center,
                            transformAlignment: Alignment.center,
                            child: SvgPicture.asset(getStorage.read("changeColor")
                                ? 'assets/images/trash_picture1.svg'
                                : "assets/images/trash_picture2.svg"),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
