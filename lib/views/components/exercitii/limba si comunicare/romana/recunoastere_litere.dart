// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart' as routes;
import 'package:lima/models/classes/custom_keyboard_layout.dart';
import 'package:lima/models/classes/difficulty_manager.dart';
import 'package:lima/models/classes/storage_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/components/help_section/help_section.dart';
import 'package:lima/views/components/skip_button/skip_button.dart';
import 'package:lima/views/components/verif_button/verif_button.dart';
import 'package:lima/models/classes/letter.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:toast/toast.dart';
import 'package:virtual_keyboard_flutter/virtual_keyboard_flutter.dart';

import '../../../../screens/level1/materii/romana1_view.dart';

class ExercitiuLitere extends StatefulWidget {
  ExercitiuLitere({Key? key, required this.level});

  int level;

  @override
  createState() => _ExercitiuLitereState();
}

class _ExercitiuLitereState extends State<ExercitiuLitere>
    with TickerProviderStateMixin {
  _ExercitiuLitereState();

  final AudioPlayer player = AudioPlayer();

  Letter? selectedLetter;

  var f1_node = FocusNode();
  var controller1 = TextEditingController();

  LinearGradient? buttonBG;
  Color skip = const Color(0xFFaaaaaa);
  final Color _audioColor = const Color(0xFF9E9E9E);

  AnimationController? audioColorAnimController;
  Animation<Color?>? audioColorAnim;

  AnimationController? audioSizeAnimController;
  Animation<double?>? audioSizeAnim;

  bool _keyboardVisible = false;
  bool _usedCheat = false;

  @override
  void initState() {
    super.initState();
    audioColorAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    audioSizeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    audioColorAnim = ColorTween(
      begin: const Color(0xFF9E9E9E),
      end: const Color(0xFFFeFeFe),
    ).animate(audioColorAnimController!);
    audioSizeAnim =
        Tween<double>(begin: 100, end: 85).animate(audioSizeAnimController!);

    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    f1_node.addListener(() => setState(() {}));
    f1_node.unfocus();

    audioColorAnimController?.addListener(() => setState(() {}));
    audioSizeAnimController?.addListener(() => setState(() {}));

    selectedLetter = Letters.letters[Random().nextInt(Letters.letters.length)];

    player.play(AssetSource(selectedLetter?.audioPath ?? ''));
  }

  @override
  void dispose() {
    player.dispose();
    audioColorAnimController!.dispose();
    audioSizeAnimController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var progress = ProgressStorage.levels[widget.level-1].comunicare.parts["romana"]!.parts["litere"]!;
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          _keyboardVisible == false
              ? const Expanded(child: SizedBox())
              : const SizedBox(height: 12),
          MouseRegion(
              onEnter: (_) {
                audioColorAnimController?.forward();
              },
              onExit: (_) {
                audioColorAnimController?.reverse();
              },
              child: GestureDetector(
                  onTap: () {
                    audioSizeAnimController
                        ?.forward()
                        .whenComplete(() => audioSizeAnimController?.reverse());
                    player.play(AssetSource(selectedLetter?.audioPath ?? ''));
                  },
                  child: Icon(LineIcon.music().icon,
                      size: audioSizeAnim?.value,
                      color: audioColorAnim?.value))),
          const SizedBox(height: 48),
          Container(
              width: 100,
              child: TextField(
                  cursorColor: const Color(0xFFC89FEB),
                  focusNode: f1_node,
                  onTap: () {
                    setState(() {
                      _keyboardVisible = true;
                      f1_node.requestFocus();
                    });
                  },
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
          _keyboardVisible == false
              ? const SizedBox(height: 25)
              : const SizedBox(height: 12),
          Text("${progress.current}",style: Theme.of(context).textTheme.headline6),
          Expanded(
              child: Column(children: [Container(
              height: size.height / 6,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      VerifButton(
                          height: size.height / 15,
                          width: size.width / 7,
                          onPressed: () {
                            var value = controller1.text;
                            if (value.toLowerCase() ==
                                selectedLetter?.character) {

                              // If the user revealed the answer ignore progression
                              // gains.
                              if (_usedCheat == true) {
                                Navigator.pop(context);
                                context.router.replace(
                                    routes.ExercitiuLitere(level: widget.level));
                                return;
                              }

                              if (progress.current < progress.total) {
                                progress.current += 1;
                                print("${progress.current}/${progress.total}");
                              } else {
                                if (progress.current > progress.total) {
                                  context.router.replace(
                                      routes.ExercitiuLitere(level: widget.level));
                                  return;
                                }
                                progress.current += 1;
                                ToastContext().init(context);
                                Toast.show(
                                    "Felicitări! Ai terminat capitolul.\nPoţi continua să exersezi sau poţi trece la următorul.",
                                    duration: 5,
                                    gravity: Toast.top,
                                    backgroundRadius: 10,
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                                        color: const Color(0xFF000000),
                                        fontFamily: "Dosis",
                                        fontSize: 25
                                    ),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFF000000)
                                    )
                                );
                              }

                              print('BRAVO');
                              context.router.replace(
                                  routes.ExercitiuLitere(level: widget.level));
                            } else if ((value.toLowerCase() == 'â' ||
                                    value.toLowerCase() == 'î') &&
                                (selectedLetter?.character == 'â' ||
                                    selectedLetter?.character == 'î')) {
                              context.router.replace(
                                  routes.ExercitiuLitere(level: widget.level));
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
                          modal: showLitereModal, exercise: routes.ExercitiuLitere(level: 1))
                    ]),
              ),
            ),
          ])),
          _keyboardVisible == true
              ? AnimatedOpacity(
                  opacity: _keyboardVisible == true ? 1 : 0,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 150),
                  child: SizedBox(
                      height: size.height / 5 + 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          Column(
                            children: [
                              Opacity(
                                opacity: 0,
                                child: IconButton(
                                  splashRadius: 30,
                                  onPressed: () =>
                                      setState(() => _keyboardVisible = false),
                                  icon: const Icon(IconlyLight.close_square),
                                ),
                              ),
                              const Expanded(child: SizedBox())
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2a2b2a),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x99000000),
                                  offset: Offset(0, 20),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            width: size.width / 2,
                            child: VirtualKeyboard(
                              fontSize: 24,
                              height: size.height / 5,
                              textColor: Colors.white,
                              type: VirtualKeyboardType.Alphanumeric,
                              textController: controller1,
                              defaultLayouts: const [
                                VirtualKeyboardDefaultLayouts.English
                              ],
                              customLayoutKeys:
                                  VirtualKeyboardRomanianLayoutKeys(),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                splashRadius: 30,
                                onPressed: () =>
                                    setState(() => _keyboardVisible = false),
                                icon: Icon(IconlyLight.close_square),
                              ),
                              const Expanded(child: SizedBox())
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      )))
              : const SizedBox(),
          const SizedBox(height: 24),
          HelpSection(showAnswer: () {
            controller1.text = selectedLetter!.character!;
            _usedCheat = true;
            },
              modal: showLitereModal)
        ]));
  }
}
