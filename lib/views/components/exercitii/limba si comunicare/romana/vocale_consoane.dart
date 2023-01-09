import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/custom_keyboard_layout.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/models/letter.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:toast/toast.dart';
import 'package:tuple/tuple.dart';
import 'package:virtual_keyboard_flutter/virtual_keyboard_flutter.dart';

import '../../../../screens/level1/materii/romana1_view.dart';

class ExercitiuVocale extends StatefulWidget {
  ExercitiuVocale({Key? key});

  @override
  createState() => _ExercitiuVocaleState();
}

class _ExercitiuVocaleState extends State<ExercitiuVocale>
  with TickerProviderStateMixin{

  _ExercitiuVocaleState();

  var f1_node = FocusNode();
  var controller1 = TextEditingController();

  LinearGradient? buttonBG;

  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
