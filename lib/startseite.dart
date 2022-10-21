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
    );
  }
}
