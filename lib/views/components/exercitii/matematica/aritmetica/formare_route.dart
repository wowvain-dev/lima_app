import 'package:flutter/material.dart';

import '../../../exercise_wrapper/exercise_wrapper.dart';

class FormareRoute extends StatefulWidget {
  FormareRoute({
    required this.exercise,
    required this.modal,
  });

  Widget exercise;
  void Function(BuildContext, void Function()) modal;

  @override
  State<FormareRoute> createState() => _FormareRouteState();
}

class _FormareRouteState extends State<FormareRoute> {
  _FormareRouteState({Key? key});

  @override
  Widget build(BuildContext context) {
    return ExerciseWrapper(
      exercise: widget.exercise,
      modal: widget.modal,
    );
  }
}

