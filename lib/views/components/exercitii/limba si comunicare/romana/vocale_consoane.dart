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
import 'package:lima/models/storage_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/models/letter.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:toast/toast.dart';
import 'package:tuple/tuple.dart';
import 'package:virtual_keyboard_flutter/virtual_keyboard_flutter.dart';

import '../../../../screens/level1/materii/romana1_view.dart';
import '../../../skip_button/skip_button.dart';
import '../../../verif_button/verif_button.dart';

class ExercitiuVocale extends StatefulWidget {
  ExercitiuVocale({Key? key});

  @override
  createState() => _ExercitiuVocaleState();
}

class _ExercitiuVocaleState extends State<ExercitiuVocale>
    with TickerProviderStateMixin {
  _ExercitiuVocaleState();

  final AudioPlayer player = AudioPlayer();

  var f1_node = FocusNode();
  var controller1 = TextEditingController();

  Letter? selectedLetter;

  void initState() {
    f1_node.addListener(() {
      setState(() {});
    });
    f1_node.unfocus();

    selectedLetter = Letters.letters[Random().nextInt(Letters.letters.length)];

    player.play(AssetSource(selectedLetter?.audioPath ?? ''));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Expanded(child: SizedBox()),
          MouseRegion(
              // onEnter: (_) {
              //   audioColorAnimController?.forward();
              // },
              // onExit: (_) {
              //   audioColorAnimController?.reverse();
              // },
              child: GestureDetector(
                  onTap: () {
                    // audioSizeAnimController
                    //     ?.forward()
                    //     .whenComplete(() => audioSizeAnimController?.reverse());
                    player.play(AssetSource(selectedLetter?.audioPath ?? ''));
                  },
                  child: Icon(LineIcon.music().icon,
                      size: 200, color: const Color(0xFFCCCCCC)))),
          const SizedBox(height: 48),
          Container(
              width: 100,
              child: TextField(
                  cursorColor: const Color(0xFFc89FEB),
                  focusNode: f1_node,
                  controller: controller1,
                  decoration: InputDecoration(
                      hintText: f1_node.hasFocus ? '' : '?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xFFC89FEB), width: 2))),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: size.width / 40))),
          Expanded(
              child: Column(children: [
            Container(
              height: 100,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      VerifButton(
                          onPressed: () {
                            var value = controller1.text;
                            if (value.toLowerCase() ==
                                selectedLetter?.character) {
                              print('BRAVO');
                              Navigator.pop(context);
                              context.router.replace(ExerciseWrapper(
                                  exercise: ExercitiuVocale(),
                                  modal: showVocaleModal));
                            } else if ((value.toLowerCase() == 'â' ||
                                    value.toLowerCase() == 'î') &&
                                (selectedLetter?.character == 'â' ||
                                    selectedLetter?.character == 'î')) {
                              Navigator.pop(context);
                              context.router.replace(ExerciseWrapper(
                                  exercise: ExercitiuVocale(),
                                  modal: showFractiiModal));
                            } else {
                              showTryAgainModal(context);
                            }
                          },
                          child: Text(
                            "Verifica",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: size.width / 60),
                          )),
                      SkipButton(
                          modal: showLitereModal, exercise: ExercitiuVocale())
                    ]),
              ),
            ),
          ]))
        ]));
  }
}
