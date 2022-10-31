/// Flutter
import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/models/sidemenu_manager.dart';

class Romana1View extends StatefulWidget {
  Romana1View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Romana1ViewState();
}

class Romana1ViewState extends State<Romana1View> {
  Romana1ViewState({Key? key});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("Romana 1"));
  }
}
