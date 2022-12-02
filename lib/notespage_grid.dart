import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesPageGrid extends StatefulWidget {
  const NotesPageGrid({Key? key}) : super(key: key);

  @override
  State<NotesPageGrid> createState() => _NotesPageGridState();
}

class _NotesPageGridState extends State<NotesPageGrid> {
  final _scrollController = ScrollController();
  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            alignment: Alignment.topCenter,
            height: 36,
            child: TextFormField(
              autofocus: false,
              controller: searchEditingController,
              keyboardType: TextInputType.text,
              onChanged: ((value) {
                setState(() {
                  var searchString = value.toLowerCase();
                });
              }),
              onSaved: (newValue) {
                searchEditingController.text = newValue!;
              },
              cursorColor: Theme.of(context).textSelectionTheme.selectionColor,
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                prefixIcon: Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  alignment: Alignment.centerLeft,
                  width: 8,
                  height: 8,
                  child: SvgPicture.asset(
                    'assets/images/search2.svg',
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                hintText: 'Search in notes',
                hintStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0XFF595550),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0XFFFFFDFA)),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0XFFFFFDFA)),
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
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
                return StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentData = snapshot.data!.docs[index];
                    return showNotes(
                      title: documentData["title"],
                      note: documentData["note"],
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

class showNotes extends StatelessWidget {
  String title, note;

  showNotes({
    Key? key,
    required this.title,
    required this.note,
  }) : super(key: key);

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
              onPressed: () {},
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
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      //overflow: TextOverflow.ellipsis,
                    ),
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
