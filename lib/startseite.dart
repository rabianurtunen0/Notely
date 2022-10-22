import 'package:flutter/material.dart';

class StartSeite extends StatefulWidget {
  const StartSeite({Key? key}) : super(key: key);

  @override
  State<StartSeite> createState() => _StartSeiteState();
}

class _StartSeiteState extends State<StartSeite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const ImageIcon(
                AssetImage('assets/images/menu.png'),
                color: Color(0XFFFFFDFA),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            '..........',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: Color(0XFFFFFDFA),
            ),
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const ImageIcon(
              AssetImage('assets/images/search.png'),
              color: Color(0XFFFFFDFA),
              ),
              onPressed: () {
                
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0XFFA3333D),
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
                onPressed: () {},
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: ImageIcon(
                        AssetImage('assets/images/file.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Padding(
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
                onPressed: () {},
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: ImageIcon(
                        AssetImage('assets/images/label.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Padding(
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
                onPressed: () {},
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: ImageIcon(
                        AssetImage('assets/images/trash.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Padding(
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
                onPressed: () {},
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: ImageIcon(
                        AssetImage('assets/images/archive.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Padding(
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
                onPressed: () {},
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 0.0),
                      child: ImageIcon(
                        AssetImage('assets/images/settings.png'),
                        color: Color(0XFFFFFDFA),
                      ),
                    ),
                    Padding(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: const Color(0XFFA3333D),
        elevation: 20,
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: const ImageIcon(
          AssetImage('assets/images/plus.png'),
          color: Color(0XFFFFFDFA),
         ),
      ),
    );
  }
}
