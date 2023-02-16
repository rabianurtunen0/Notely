import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notely/labels.dart';

class LabelNotes extends StatefulWidget {
  const LabelNotes({Key? key}) : super(key: key);

  @override
  State<LabelNotes> createState() => _LabelNotesState();
}

class _LabelNotesState extends State<LabelNotes> {
  final _scrollController = ScrollController();
  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.to(const Labels()),
          icon: SvgPicture.asset(
            'assets/images/arrow_left.svg',
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          splashRadius: 25.0,
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            getStorage.read("labelName"),
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

    );
  }
}