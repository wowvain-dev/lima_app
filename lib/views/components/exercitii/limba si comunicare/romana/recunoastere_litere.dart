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
import 'package:virtual_keyboard_flutter/virtual_keyboard_flutter.dart';

import '../../../../screens/level1/materii/romana1_view.dart';

class ExercitiuLitere extends StatefulWidget {
  ExercitiuLitere({Key? key});

  @override
  createState() => _ExercitiuLitereState();

}

class _ExercitiuLitereState extends State<ExercitiuLitere>
    with TickerProviderStateMixin {

  _ExercitiuLitereState();

  List<Letter> letters = List.empty(growable: true);
  final JsonDecoder decoder = JsonDecoder();
  final AudioPlayer player = AudioPlayer();

  Letter? selectedLetter;

  var f1_node = FocusNode();
  var controller1 = TextEditingController();

  LinearGradient? buttonBG;
  Color skip = const Color(0xFFaaaaaa);
  Color _audioColor = const Color(0xFF9E9E9E);

  AnimationController? audioColorAnimController;
  Animation<Color?>? audioColorAnim;

  AnimationController? audioSizeAnimController;
  Animation<double?>? audioSizeAnim;

  bool keyboardVisible = false;

  @override
  void initState() {
    audioColorAnimController = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 250)
    );
    audioSizeAnimController = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    audioColorAnim = ColorTween(
      begin: const Color(0xFF9E9E9E),
      end: const Color(0xFFFeFeFe),
    ).animate(audioColorAnimController!);
    audioSizeAnim = Tween<double>(
      begin: 100, end: 85
    ).animate(audioSizeAnimController!);

    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    f1_node.addListener(() => setState((){}));
    f1_node.unfocus();

    var jsonString = File(".\\assets\\json\\litere.json").readAsStringSync();
    final Map<String, dynamic> jsonMap = decoder.convert(jsonString);

    var value = jsonMap["letters"];
    if (value != null) {
      value.forEach((item) => letters.add(
        Letter(character: item["letter"], audioPath: item["recording"])
      ));
    }

    audioColorAnimController?.addListener(() => setState(() {}));
    audioSizeAnimController?.addListener(() => setState(() {}));

    selectedLetter = letters[Random().nextInt(letters.length)];

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
    // print(selectedLetter?.audioPath);
    // player.play(AssetSource(selectedLetter?.audioPath ?? ''));
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          keyboardVisible == false ? const Expanded(child: SizedBox())
              : const SizedBox(height: 12),
          MouseRegion(
            onEnter: (_) {
              audioColorAnimController?.forward();
            }, onExit: (_) {
              audioColorAnimController?.reverse();
          },
            child: GestureDetector(
              onTap: () {
                audioSizeAnimController?.forward().whenComplete(() => audioSizeAnimController?.reverse());
                player.play(AssetSource(selectedLetter?.audioPath ?? ''));
              },
              child: Icon(LineIcon.music(
              ).icon, size: audioSizeAnim?.value, color: audioColorAnim?.value)
            )
          ),
          const SizedBox(height: 48),
          Container(
            width: 100,
            child: TextField(
              cursorColor: const Color(0xFFC89FEB),
              focusNode: f1_node,
              onTap: () {setState(() {
                keyboardVisible = true;
              });},
              controller: controller1,
              decoration: InputDecoration(
                hintText: f1_node.hasFocus ? '' : '?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xFFC89FEB), width: 2))
                  ),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith( fontSize: size.width / 40
                )
              )
            ),
          keyboardVisible == false ? const Expanded(child: SizedBox())
          : const SizedBox(height: 12),
          Expanded(
              child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              MouseRegion(
                                  onExit: (_) {
                                    setState(() {
                                      buttonBG = const LinearGradient(
                                        colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      );
                                    });
                                  },
                                  onEnter: (_) {
                                    setState(() {
                                      buttonBG = const LinearGradient(
                                        colors: [
                                          Color(0xFF576182),
                                          Color(0xFF1FC5A8),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      );
                                    });
                                  },
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Future.delayed(Duration.zero, () {
                                            buttonBG = const LinearGradient(
                                                colors: [
                                                  Color(0xFF5D69BE),
                                                  Color(0xFFC89FEB)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight);
                                          }).whenComplete(() {
                                            Future.delayed(
                                                const Duration(milliseconds: 200), () {
                                              setState(() {
                                                buttonBG = const LinearGradient(
                                                  colors: [
                                                    Color(0xFF576182),
                                                    Color(0xFF1FC5A8),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                );
                                              });
                                            });
                                          });
                                        });

                                        var value = controller1.text;

                                        /// TODO(wowvain-dev): CREATE SEPARATE SMALL HEIGHT LAYOUT
                                        /// TODO(wowvain-dev): MAKE ALL POSSIBLE CHECKS FOR THE VALUE INSIDE THE TextFields
                                        /// TODO(wowvain-dev): TRY ADDING TEXTURE FOR THE SLICES

                                        if (value.toLowerCase() == selectedLetter?.character) {
                                          print ('BRAVO');
                                          Navigator.pop(context);
                                          context.router.replace(
                                              ExerciseWrapper(
                                                  exercise: ExercitiuLitere(),
                                                  modal: showFractiiModal
                                              ));
                                        } else {
                                          showTryAgainModal(context);
                                        }
                                      },
                                      child: AnimatedContainer(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x99000000),
                                                spreadRadius: 2,
                                                blurRadius: 20,
                                                offset: Offset(0, 20),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(15),
                                            gradient: buttonBG,
                                          ),
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                          child: Text("Verifică",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(fontSize: size.width / 60))))),
                              MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    skip = const Color(0xFFFEFEFE);
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    skip = const Color(0xFFaaaaaa);
                                  });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    context.router.push(ExerciseWrapper(
                                        exercise: ExercitiuLitere(), modal: showLitereModal));
                                  },
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(top: 10),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                    child: Text("Treceţi Peste",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: skip)),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),

                  ]
              )
          ),

          keyboardVisible == true ? AnimatedOpacity(
            opacity: keyboardVisible == true ? 1 : 0,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 150),
            child: SizedBox(
            height: size.height / 4 + 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox()),
                Container(
                  // margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 1, ),
                  ),
                  width: size.width / 2,
                  child: VirtualKeyboard(
                    height: size.height / 4,
                    textColor: Colors.white,
                    type: VirtualKeyboardType.Alphanumeric,
                    textController: controller1,
                    defaultLayouts: [
                      VirtualKeyboardDefaultLayouts.English
                    ],
                    customLayoutKeys: VirtualKeyboardRomanianLayoutKeys(),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      splashRadius: 30,
                      onPressed: () => setState(() => keyboardVisible = false),
                      icon: Icon(IconlyLight.close_square),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                Expanded(child: SizedBox()),
              ],
            )
          )) : SizedBox(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width / 4),
            height: size.height / 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text("Ce trebuie să fac?",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey, fontSize: size.width / 70)),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  width: 2,
                ),
                Expanded(
                  child: Center(
                    child: Text("Arată răspunsul",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey, fontSize: size.width / 70)),
                  ),
                )
              ],
            ),
          )
        ]
      )
    );
  }

}