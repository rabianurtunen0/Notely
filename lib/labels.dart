import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/archivepage.dart';
import 'package:notely/labelnotes.dart';
import 'package:notely/setting.dart';
import 'package:notely/startseite.dart';
import 'package:notely/trashpage.dart';

class Labels extends StatefulWidget {
  const Labels({Key? key}) : super(key: key);

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  final searchEditingController = TextEditingController();
  final labelEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final getStorage = GetStorage();
  bool search = false;
  static List<dynamic> listLabels = []; 
  static List<dynamic> searchLabels = [];
  bool add_label = false;

  callback(newListLabels, newAdd_label) {
    setState(() {
      listLabels = newListLabels;
      add_label = newAdd_label;
    });
  }

  @override
  void initState () {
    searchLabels = listLabels;
    super.initState();
  }

  void runFilter() {
    List<dynamic> resultsLabels = [];
    
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
          'Label list',
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
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
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
                        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                        alignment: Alignment.center,
                        height: 48,
                        width: MediaQuery.of(context).size.width,
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
                          cursorColor: Theme.of(context).backgroundColor ==
                              const Color(0XFFEAEAEA)
                          ? const Color(0XFF2A2B2E)
                          : const Color(0XFFEAEAEA),
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.bottom,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0XFF2A2B2E)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            prefixIcon: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 0.0, 0.0),
                              alignment: Alignment.centerLeft,
                              width: 8,
                              height: 8,
                              child: SvgPicture.asset(
                                  'assets/images/search2.svg',
                                  color: Theme.of(context).backgroundColor ==
                              const Color(0XFFEAEAEA)
                          ? const Color(0XFF2A2B2E)
                          : const Color(0XFFEAEAEA),
                          ),
                            ),
                            hintText: 'Search in labels',
                            hintStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0XFF595550),
                            ), 
                            suffixIcon: searchEditingController.text == ""
                              ? null
                              : Container(
                                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                alignment: Alignment.centerLeft,
                                width: 8,
                                height: 8,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchEditingController.clear();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color(0XFF2A2B2E),
                                  ),
                                ),
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).backgroundColor ==
                                  const Color(0XFFEAEAEA)
                                      ? const Color(0XFF2A2B2E)
                                      : const Color(0XFFEAEAEA),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).backgroundColor ==
                                  const Color(0XFFEAEAEA)
                                      ? const Color(0XFF2A2B2E)
                                      : const Color(0XFFEAEAEA),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        height: 0,
                      ),
                searchEditingController.text.isNotEmpty 
                    ? Container(
                        color: Colors.transparent,
                        height: 0,
                      )
                    : Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(4.0, 20.0, 0.0, 8.0),
                        child: Text(
                          'New label',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Theme.of(context).textSelectionTheme.selectionColor,
                          ),
                        ),
                      ),
                searchEditingController.text.isNotEmpty 
                    ? Container(
                        color: Colors.transparent,
                        height: 0,
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 20.0),
                        child: Row(
                          children: [
                            Container(
                              width: 320,
                              height: 48,
                              child: TextFormField(
                                enableInteractiveSelection: true,
                                autofocus: false,
                                controller: labelEditingController,
                                keyboardType: TextInputType.text,
                                toolbarOptions: const ToolbarOptions(paste: true, cut: true, selectAll: true, copy: true),
                                onSaved: (newValue) {
                                  labelEditingController.text = newValue!;
                                },
                                cursorColor: const Color(0XFF2A2B2E),
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Theme.of(context).textSelectionTheme.selectionColor,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0XFFFFFDFA),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12.0, 13.0, 12.0, 13.0),
                                  hintText: 'Enter label name..',
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Theme.of(context).textSelectionTheme.selectionColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0XFFFFFDFA)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0XFFFFFDFA)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width:48,
                              height:48,
                              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(12.0),
                                color: getStorage.read("changeColor")
                                    ? const Color(0XFFA3333D)
                                    : const Color(0XFF613DC1),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onPressed: () {
                                    add_label = true;
                                    createLabel();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/check.svg',
                                    width: 30,
                                    height: 30,
                                    color: const Color(0XFFFFFDFA),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).backgroundColor,
                  child: searchEditingController.text.isNotEmpty 
                    ? ListView.builder(
                      controller: _scrollController,
                      itemCount: searchLabels.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return showLabels(
                          label: listLabels[index][0], 
                          labelId: listLabels[index][1],
                          listLabels: listLabels, 
                          add_label: add_label, 
                          callback: callback
                        );
                      }
                      )
                    : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser?.email)
                          .collection('Labels')
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
                              return showLabels(
                                label: documentData["label"],
                                labelId: documentData["labelId"],
                                listLabels: listLabels,
                                add_label: add_label,
                                callback: callback,
                              );
                            },
                          );
                        } 
                        else {
                          return Container();
                        }
                      },
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  void createLabel () async {
    if(labelEditingController.text.isNotEmpty) {
      DocumentReference documentRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("Labels")
        .doc();
    var querySnapshots = await documentRef.get();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Labels')
        .doc(querySnapshots.id)
        .set({
          'label': labelEditingController.text,
          'labelId': querySnapshots.id,
          'date': DateTime.now(),
        });
    listLabels.add([labelEditingController.text, querySnapshots.id]);
    print(listLabels);
    labelEditingController.clear();
    }
    else {
      Fluttertoast.showToast(
        msg: "Please, ",
        backgroundColor: getStorage.read("changeColor")
          ? const Color(0XFFA3333D)
          : const Color(0XFF613DC1),
        textColor: const Color(0XFFFFFDFA),
        fontSize: 14.0,
        timeInSecForIosWeb: 2,
      );
    }
  }
}

class showLabels extends StatefulWidget {
  String label, labelId;
  List listLabels;
  bool add_label;
  Function(String, String) callback;

  showLabels({
    Key? key,
    required this.label,
    required this.labelId,
    required this.listLabels,
    required this.add_label,
    required this.callback,
  }) : super(key: key);

  @override
  State<showLabels> createState() => _showLabelsState();
}

class _showLabelsState extends State<showLabels> {
  final getStorage = GetStorage();
  late final labelEditEditingController = TextEditingController(text: widget.label);
  bool edit = false;
  int editNumber = 0;
  
  void initState() {
    widget.add_label == false 
        ? widget.listLabels.add([widget.label, widget.labelId]) 
        : null;
    print(widget.listLabels);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin : const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
          onPressed: () {
            setState(() {
              getStorage.write("labelName", widget.label);
              widget.listLabels.clear();
              Get.to(const LabelNotes());
            });
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            primary: Theme.of(context).textSelectionTheme.selectionColor,
            side: BorderSide(
              color: getStorage.read("changeColor")
                  ? const Color(0XFFA3333D)
                  : const Color(0XFF613DC1),
              width: edit ? 2.0 : 1.0,
            ),
            backgroundColor: Colors.transparent,
          ),
          child: Container(
            alignment: Alignment.center,
            height: 52,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              horizontalTitleGap: 0.0, 
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: Container(
                child: edit 
                ? IconButton(
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    int select = 0;
                    for (var label in widget.listLabels) {
                      if (label[1] == widget.labelId) {
                        select = widget.listLabels.indexOf(label);
                      }
                    }
                    widget.listLabels.removeAt(select);
                    print(widget.listLabels);
                    deleteLabel();
                    edit = false;
                  },
                  icon: SvgPicture.asset(
                    'assets/images/trash.svg',
                    color: Theme.of(context).backgroundColor ==
                        const Color(0XFFEAEAEA)
                      ? const Color(0XFF2A2B2E)
                      : const Color(0XFFEAEAEA),
                  ),
                  splashRadius: 1.0,
                ) 
                : SvgPicture.asset(
                  'assets/images/label.svg',
                  color: Theme.of(context).backgroundColor ==
                      const Color(0XFFEAEAEA)
                    ? const Color(0XFF2A2B2E)
                    : const Color(0XFFEAEAEA),
                ),
              ),
              title: Row(
                children: [
                  edit
                  ? Container(
                    width: 260,
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: labelEditEditingController,
                      keyboardType: TextInputType.text,
                      toolbarOptions: const ToolbarOptions(paste: true, cut: true, selectAll: true, copy: true),
                      onSaved: (newValue) {
                        labelEditEditingController.text = newValue!;
                      },
                      cursorColor: Theme.of(context).textSelectionTheme.selectionColor,
                      cursorHeight: 12.0,
                      textInputAction: TextInputAction.next,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: getStorage.read("changeColor")
                                  ? const Color(0XFFA3333D)
                                  : const Color(0XFF613DC1),
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: getStorage.read("changeColor")
                                ? const Color(0XFFA3333D)
                                : const Color(0XFF613DC1),
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                    ),
                  )
                  : Text(
                      widget.label, 
                      maxLines: 1,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                    widget.labelId,
                    style: const TextStyle(fontSize: 0),
                  )
                ],
              ),
              trailing: Container(
                child: edit 
                ? IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      int select = 0;
                      for (var label in widget.listLabels) {
                        if (label[1] == widget.labelId) {
                          select = widget.listLabels.indexOf(label);
                        }
                      }
                      widget.listLabels.removeAt(select);
                      editLabel();
                      edit = false;
                    },
                    icon: SvgPicture.asset(
                      'assets/images/check.svg',
                      color: Theme.of(context).backgroundColor ==
                            const Color(0XFFEAEAEA)
                          ? const Color(0XFF2A2B2E)
                          : const Color(0XFFEAEAEA),
                      width: 28,
                      height: 28,
                    ),
                    splashRadius: 1.0,
                  ) 
                : IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });  
                  },
                  icon: SvgPicture.asset(
                    'assets/images/edit.svg',
                    color: Theme.of(context).backgroundColor ==
                          const Color(0XFFEAEAEA)
                        ? const Color(0XFF2A2B2E)
                        : const Color(0XFFEAEAEA),
                  ),
                  splashRadius: 1.0,
                ),
              ),
            ),
          ),
        ),
    );
  }

  void editLabel () async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Labels')
        .doc(widget.labelId)
        .update({
      "label": labelEditEditingController.text,
    });
    widget.listLabels.add([labelEditEditingController.text, widget.labelId]);
    print(widget.listLabels);
  }

  void deleteLabel () async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Labels')
        .doc(widget.labelId)
        .delete();
  }
  
}