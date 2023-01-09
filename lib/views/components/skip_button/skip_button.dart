import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import '../../../app/router.gr.dart';
import '../../screens/level1/materii/romana1_view.dart';
import '../exercitii/limba si comunicare/romana/recunoastere_litere.dart';

/// TODO(wowvain-dev):  MODULARIZE PROPERLY (WRAPPER AND MODALS)

class SkipButton extends StatefulWidget {
  SkipButton({required this.onPressed, required this.child});

  void Function() onPressed;
  Widget child;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SkipButtonState(
      onPressed, child
  );
}

class _SkipButtonState extends State<SkipButton> {
  _SkipButtonState(this.onPressed, this.child);

  void Function() onPressed;
  Widget child;

  LinearGradient _buttonBG = const LinearGradient(
      colors: [Color(0xFFFFFFFF)]
  );
  Color _skip = const Color(0xFFaaaaaa);

  @override
  void initState() {
    _buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      MouseRegion(
        onEnter: (_) {
          setState(() {
            _skip = const Color(0xFFFEFEFE);
          });
        },
        onExit: (_) {
          setState(() {
            _skip = const Color(0xFFaaaaaa);
          });
        },
        child: GestureDetector(
          onTap: () {
            context.router.push(ExerciseWrapper(
                exercise: ExercitiuLitere(),
                modal: showLitereModal));
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(top: 10),
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            child: Text("Treceţi Peste",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: _skip)),
          ),
        ),
      );
  }
}
