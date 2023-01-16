import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:lima/app/router.gr.dart' as routes;
import 'package:lima/models/classes/storage_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/models/classes/letter.dart';
import 'package:lima/views/components/help_section/help_section.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:toast/toast.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/models/classes/header_manager.dart';

import '../../../../screens/level1/materii/romana1_view.dart';
import '../../../skip_button/skip_button.dart';
import '../../../verif_button/verif_button.dart';

class ExercitiuVocale extends StatefulWidget {
  ExercitiuVocale({Key? key, required this.level});

  int level;

  @override
  createState() => _ExercitiuVocaleState();
}

class _ExercitiuVocaleState extends State<ExercitiuVocale>
    with TickerProviderStateMixin {
  _ExercitiuVocaleState();

  final AudioPlayer player = AudioPlayer();

  var f1_node = FocusNode();
  var controller1 = TextEditingController();

  bool _usedCheat = false;


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
    f1_node.removeListener(() {setState(() {

    });});
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var progress = ProgressStorage.levels[widget.level-1].comunicare
      .parts["romana"]!.parts["vocale"]!;
        return Container(
            color: const Color(0xFF2a2b2a),
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
                                child: GestureDetector(
                                    onTap: () {
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
                                                  height: size.height / 15,
                                                  width: size.width / 7,
                                                  onPressed: () => _verify(LetterType.vowel),
                                                  child: Text(
                                                    "VOCALA",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(fontSize: size.width / 60),
                                                  )),
                                              VerifButton(
                                                height: size.height / 15,
                                                width: size.width / 7,
                                                onPressed: () => _verify(LetterType.consonant),
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
                                          modal: showLitereModal, exercise: routes.ExercitiuVocale(level: 1)
                                      ),
                                    ]),
                              ),
                            ),
                          ])),
                  HelpSection(
                      showAnswer: () {
                        _usedCheat = true;
                      },
                      modal: showVocaleModal)
                ]));
  }

  void _verify(LetterType _type) {
    l<HeaderManager>().update();
    var progress = ProgressStorage.levels[widget.level-1].comunicare
      .parts["romana"]!.parts["vocale"]!;
    if (selectedLetter!.letterType ==
        _type
    ) {
      if (_usedCheat) {
        context.router.pop(context);
        context.router.push(
            routes.ExercitiuVocale(level: widget.level));
        return;
      }
      if (progress.ogCurrent < progress.ogTotal) {
        progress.ogCurrent += 1;
        print("${progress.ogCurrent}/${progress.ogTotal}");
      } else {
        if (progress.ogCurrent > progress.ogTotal) {
          context.router.pop(context);
          context.router.push(
              routes.ExercitiuVocale(level: widget.level));
          return;
        }
        progress.ogCurrent += 1;
        // TODO: add CONFETII for completing the exercise
        ToastContext().init(context);
        Toast.show(
            "Felicitări! Ai terminat capitolul.\nPoţi continua să exersezi sau poţi trece la următorul.",
            duration: 5,
            gravity: Toast.top,
            backgroundRadius: 10,
            backgroundColor: const Color(0xFFFFFFFF),
            textStyle: Theme
                .of(context)
                .textTheme
                .headline6!
                .copyWith(
                color: const Color(0xFF000000),
                fontFamily: "Dosis",
                fontSize: 25
            ),
            border: Border.all(
                width: 2,
                color: const Color(0xFF000000)
            )
        );
        context.router.pop(context);
        context.router.push(
            routes.ExercitiuVocale(level: widget.level));
        return;
      }
      context.router.pop(context);
      context.router.push(
          routes.ExercitiuVocale(level: widget.level));
      return;
    } else {
      showTryAgainModal(context);
    }
  }
    }
