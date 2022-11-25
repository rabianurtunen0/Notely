import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/startseite.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.to(const StartSeite()),
          icon: ImageIcon(
            const AssetImage('assets/images/arrow_left.png'),
            color: Theme.of(context).highlightColor,
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
              icon: ImageIcon(
                const AssetImage('assets/images/more.png'),
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onPressed: () {
                bottomSheet();
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: TextField(
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
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              width: MediaQuery.of(context).size.width,
              child: TextField(
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
          height: 300.0,
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
                
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0.0, 0.0),
                      child: const ImageIcon(
                        AssetImage('assets/images/file_delete.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 18.0, 0.0, 0.0),
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
                height: 60.0,
                splashColor: Colors.transparent,
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: const ImageIcon(
                        AssetImage('assets/images/copy.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 0.0, 0.0),
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
                height: 60.0,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: const ImageIcon(
                        AssetImage('assets/images/share.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 0.0, 0.0),
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
                height: 60.0,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: const ImageIcon(
                        AssetImage('assets/images/label.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 0.0, 0.0),
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
                height: 60.0,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                
                },
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: const ImageIcon(
                        AssetImage('assets/images/archive.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 0.0, 0.0),
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
}
