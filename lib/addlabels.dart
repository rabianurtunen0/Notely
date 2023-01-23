import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/addnote.dart';
import 'package:notely/labels.dart';

class AddLabels extends StatefulWidget {
  const AddLabels({Key? key}) : super(key: key);

  @override
  State<AddLabels> createState() => _AddLabelsState();
}

class _AddLabelsState extends State<AddLabels> {
  final _scrollController = ScrollController();
  final getStorage = GetStorage();
  final searchEditingController = TextEditingController();  

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
            Get.to(const AddNote());
            addLabels();
            
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
            "Label list",
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
              splashRadius: 25.0,
            ),
          ),
        ],
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
                        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 30.0), 
                        alignment: Alignment.center,
                        height: 42,
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
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                //color: Color(0XFFFFFDFA),
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                      )
                    : Container(
                      color: Colors.transparent,
                      height: 0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).backgroundColor,
                      child: StreamBuilder<QuerySnapshot>(
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

  void addLabels() async {
    

  }
}

class showLabels extends StatefulWidget {
  String label, labelId;

  showLabels({
    Key? key,
    required this.label,
    required this.labelId,
  }) : super(key: key);

  @override
  State<showLabels> createState() => _showLabelsState();
}

class _showLabelsState extends State<showLabels> {
  final getStorage = GetStorage();
  late bool isChecked = false;
  static List<dynamic> list_labels = [];

  void addedLabels () async {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('Notes')
        .doc(getStorage.read("noteId"));
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    var labels = data?['labels'];
    setState(() {
      // print(labels);
      list_labels = labels;
      // print(list_labels.length);
      labelSelect();
    });
  }
  
  labelSelect () {
    for(var i = 0; i < list_labels.length; i++) {
      if(list_labels[i] == widget.label){
        isChecked = true;
      }
    }
    return false;
  }

  @override
  void initState() {
    addedLabels();
    super.initState();
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
              leading: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: getStorage.read("changeColor")
                  ? const Color(0XFFA3333D)
                  : const Color(0XFF613DC1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                side: BorderSide(
                  color: getStorage.read("changeColor")
                      ? const Color(0XFFA3333D)
                      : const Color(0XFF613DC1),
                  width: 1.5,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    
                    isChecked == false 
                      ? list_labels.remove(widget.label) 
                      : list_labels.add(widget.label);
                      
                });
                    
/*
                    for(var i = 0; i<=list_labels.length; i++) {
                        list_labels[i] == widget.label 
                          ? list_labels.remove(widget.label)
                          : list_labels.add(widget.label);
                      }
                    */
                    print(list_labels);
                
                },
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5.0),
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.label, 
                      maxLines: 1,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.labelId,
                    style: const TextStyle(fontSize: 0),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

