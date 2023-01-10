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
import 'package:lima/views/components/help_section/help_section.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:resize/resize.dart';
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
  BuildContext? _context;

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
    _context = context;
    var size = MediaQuery.of(context).size;
        return Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child :Column(
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
                                    child: Text(selectedLetter!.character?.toUpperCase() ?? '',
                                        style: Theme.of(context).textTheme.headline6!
                                            .copyWith(fontSize: size.width / 10)
                                    ))),
                            const Expanded(child: SizedBox())
                          ]
                      )),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        width: size.width / 2,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              VerifButton(
                                                  height: 100,
                                                  width: 250,
                                                  onPressed: () {
                                                    if (selectedLetter!.letterType ==
                                                        LetterType.vowel
                                                    ) {
                                                      Navigator.pop(context);
                                                      context.router.replace(ExerciseWrapper(
                                                          exercise: ExercitiuVocale(),
                                                          modal: showFractiiModal));
                                                    } else {
                                                      showTryAgainModal(context);
                                                    }
                                                  },
                                                  child: Text(
                                                    "VOCALA",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(fontSize: size.width / 60),
                                                  )),
                                              VerifButton(
                                                height: 100,
                                                width: 250,
                                                onPressed: () {
                                                  if (selectedLetter!.letterType ==
                                                      LetterType.consonant
                                                  ) {
                                                    Navigator.pop(context);
                                                    context.router.replace(ExerciseWrapper(
                                                        exercise: ExercitiuVocale(),
                                                        modal: showFractiiModal));
                                                  } else {
                                                    showTryAgainModal(context);
                                                  }
                                                },
                                                child: Text(
                                                    "CONSOANA",
                                                    style: Theme.of(context).textTheme.
                                                    headline6!.copyWith(fontSize: size.width / 60)
                                                ),
                                              )
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      SkipButton(
                                          modal: showLitereModal, exercise: ExercitiuVocale())
                                    ]),
                              ),
                            ),
                          ])),
                  HelpSection(
                      showAnswer: () {

                      },
                      modal: showVocaleModal)
                ]));
  }
}
