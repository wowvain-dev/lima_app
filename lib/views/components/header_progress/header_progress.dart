import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/models/classes/header_manager.dart';
import 'package:lima/models/classes/storage_manager.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class HeaderProgress extends StatefulWidget {
  HeaderProgress({
    Key? key,
    required String this.route,
    double this.height = 50,
    double this.width = 200,
    this.barColor = null,
    this.bgColor = null,
    this.strokeColor = null,
    this.showPercentage = false
  });

  String route;
  double height;
  double width;
  Color? barColor;
  Color? bgColor;
  Color? strokeColor;
  bool showPercentage;

  @override
  State<HeaderProgress> createState() => _HeaderProgressState();
}

class _HeaderProgressState extends State<HeaderProgress> {

  @override
  void initState() {
    l<HeaderManager>().addListener((){
      if (mounted) {
        setState((){});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    l<HeaderManager>().removeListener(() {
      if (mounted) {
        setState((){});
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _progress = 0;
    int _current = 0;
    int _total = 0;
    // var currentPath = context.router.currentPath;
    var currentPath = widget.route;
    if (widget.route == '') currentPath = context.router.currentPath;
    var paths = currentPath.split('/');
    paths.removeAt(0);
    print("THE CURRENT HEADER PATH IS: ${paths}");

    var firstRoute = paths.first;
    var lastRoute = paths.last;

    if (lastRoute.contains('level')) {
      _progress = ProgressStorage.levels[
        int.parse(lastRoute[lastRoute.length-1]) - 1].percentage;
      _current = ProgressStorage.levels[
      int.parse(lastRoute[lastRoute.length-1]) - 1].current;
      _total = ProgressStorage.levels[
      int.parse(lastRoute[lastRoute.length-1]) - 1].total;
    } else {
      switch(lastRoute) {
        case "aritmetica":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.current;
          _total = ProgressStorage.levels[
            int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.total;
          break;
        case "geometrie":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["geometrie"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["geometrie"]!.current;
          _total = ProgressStorage.levels[
            int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["geometrie"]!.total;
          break;
        case "romana":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.current;
          _total = ProgressStorage.levels[
            int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.total;
          break;
        case "operatii":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["operatii"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["operatii"]!.current;
          _total = ProgressStorage.levels[
            int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["operatii"]!.total;
          break;
        case "fractii":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["fractii"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["fractii"]!.current;
          _total = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["fractii"]!.total;
          break;
        case "siruri":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["siruri"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["siruri"]!.current;
          _total = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["siruri"]!.total;
          break;
        case "formare":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["formare"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["formare"]!.current;
          _total = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].matematica.parts["aritmetica"]!.parts["formare"]!.total;
          break;
        case "litere":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["litere"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["litere"]!.current;
          _total = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["litere"]!.total;
          break;
        case "vocale":
          _progress = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["vocale"]!.percentage;
          _current = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["vocale"]!.current;
          _total = ProgressStorage.levels[
          int.parse(firstRoute[firstRoute.length-1]) - 1
          ].comunicare.parts["romana"]!.parts["vocale"]!.total;
          break;
      }
    }
    print(_progress);

    return Container(
      child: Stack(
        children: [
          AnimatedProgressBar(
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
              value: _progress,
              height: widget.height,
              width: widget.width,
            backgroundColor: widget.bgColor ?? const Color(0xFF252525),
            color: widget.barColor,
            gradient: widget.barColor == null ? const LinearGradient(
              colors: [
                Color(0xFFff1d25),
                Color(0xFF6049b0),
                Color(0xFF0082e6)
              ]
            ) : null
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: widget.strokeColor ?? const Color(0xFFfefefe),
                width: 2
              )
            ),
            height: widget.height,
            width: widget.width,
            child: Center(
              child:
              widget.showPercentage == true ? Text("${(_progress * 100).toStringAsFixed(2)}%",
                style: Theme.of(context).textTheme.headline6!
                  .copyWith(
                  fontSize: widget.height / 2
                )
              ) : Text("${_current} / ${_total}",
                style: Theme.of(context).textTheme.headline6!
                  .copyWith(
                  fontSize: widget.height / 2
                )
              )
            )
          )
        ]
      )
    );
  }

}