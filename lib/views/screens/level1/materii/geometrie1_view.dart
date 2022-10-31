/// Flutter
import 'package:flutter/material.dart';

class Geometrie1View extends StatefulWidget {
  Geometrie1View({Key? key}) : super(key: key);

  @override 
  State<StatefulWidget> createState() => Geometrie1ViewState();
}

class Geometrie1ViewState extends State<Geometrie1View> {
  Geometrie1ViewState({Key? key}); 

  @override
  void initState() {

    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Geometrie 1"),
        ],
      )
    );
  }
}