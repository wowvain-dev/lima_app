import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class ExerciseWrapper extends StatefulWidget {
  ExerciseWrapper({
    Key? key,
    required this.exercise,
    required this.modal,
  });

  /// The exercise inside the wrapper.
  Widget exercise;

  /// The modal function to show when in need of help.
  void Function(BuildContext, void Function()) modal;

  @override
  State<StatefulWidget> createState() => _ExerciseWrapperState(
        exercise: exercise,
        modal: modal,
      );
}

class _ExerciseWrapperState extends State<ExerciseWrapper> {
  _ExerciseWrapperState({
    Key? key,
    required this.exercise,
    required this.modal,
  });

  /// The exercise inside the wrapper.
  Widget exercise;

  /// The modal function to show when in need of help.
  void Function(BuildContext, void Function()) modal;

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          margin: EdgeInsets.only(
              bottom: constraints.maxHeight / 25,
              top: constraints.maxHeight / 25),
          child: Column(children: [
            SizedBox(height: constraints.maxHeight / 30),
            Expanded(child: Container(child: exercise)),
          ]));
    });
  }
}

void showTryAgainModal(BuildContext context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(Duration.zero, () {
        }).whenComplete(() => Future.delayed(Duration(seconds: 2), () => Navigator.pop(context)));
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
              colors: [Color(0xFFffc3a0), Color(0xFFffafbd)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                  colors: [
                    Color(0xFF29323c),
                    Color(0xFF485563),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.heart, size: 40), 
                    SizedBox(height: 20),
                    Text("Ai fost aproape! Încearcă iar!",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: MediaQuery.of(context).size.width / 50,
                            )),
                  ],
                )),
          ),
        );
      });
}
