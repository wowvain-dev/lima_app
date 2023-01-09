import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../app/router.gr.dart';

/// TODO(wowvain-dev):  MODULARIZE PROPERLY (WRAPPER AND MODALS)

class SkipButton extends StatefulWidget {
  SkipButton({required this.modal, required this.exercise});

  void Function(BuildContext, void Function()) modal;
  Widget exercise;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SkipButtonState(
      modal, exercise
  );
}

class _SkipButtonState extends State<SkipButton> {
  _SkipButtonState(this.modal, this.exercise);

  void Function(BuildContext, void Function()) modal;
  Widget exercise;

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
    return MouseRegion(
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
                exercise: exercise,
                modal: modal));
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
