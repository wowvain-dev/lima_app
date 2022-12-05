import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/models/expression_tree.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:switcher/switcher.dart';

import 'package:toast/toast.dart';

import 'package:lima/app/router.gr.dart' as routes;

import '../exercitii/matematica/aritmetica/fractii.dart';
import '../exercitii/matematica/aritmetica/operatii.dart';

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

  Color? settingsColor;
  initState() {
    settingsColor = const Color(0xFFaaaaaa);
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          margin: EdgeInsets.only(
            bottom: constraints.maxHeight / 25,
          ),
          child: Column(children: [
            SizedBox(
                height: constraints.maxHeight / 30 + constraints.maxHeight / 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: MouseRegion(
                    onEnter: (_) {
                      if (mounted) {
                        setState(() {
                          settingsColor = const Color(0xFFFEFEFE);
                        });
                      }
                    },
                    onExit: (_) {
                      if (mounted) {
                        setState(() {
                          settingsColor = const Color(0xFFAAAAAA);
                        });
                      }
                    },
                    child: GestureDetector(
                        onTap: () {
                          showSettingsModal(exercise, context, modal);
                        },
                        child: AnimatedContainer(
                            margin: const EdgeInsets.only(right: 24, top: 10),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            child: Icon(
                              Iconsax.setting_2,
                              color: settingsColor,
                              size: 48,
                            ))),
                  ),
                )),
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
        Future.delayed(Duration.zero, () {}).whenComplete(() => Future.delayed(
            const Duration(seconds: 2), () => Navigator.pop(context)));
        return Dialog(
          backgroundColor: Colors.transparent,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5D69BE),
                        Color(0xFFC89FEB),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(IconlyLight.heart, size: 40, shadows: [
                      Shadow(
                          color: Color(0xFF000000),
                          blurRadius: 15,
                          offset: Offset(0.0, 5))
                    ]),
                    const SizedBox(height: 20),
                    Text("Ai fost aproape! Încearcă iar!",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: MediaQuery.of(context).size.width / 50,
                            shadows: const [
                              Shadow(
                                  color: Color(0xFF000000),
                                  blurRadius: 15,
                                  offset: Offset(0.0, 5))
                            ])),
                  ],
                )),
          ),
        );
      });
}

void showSettingsModal(Widget exercise, BuildContext context,
    void Function(BuildContext, void Function()) modal) async {
  if (exercise is Operatii) {
    showOperatiiSettingsModal(context, modal);
  }

  if (exercise is Fractii) {
    showFractionSettingsModal(context, modal);
  }

  // if (exercise is Operatii) {

  // }
}

void showOperatiiSettingsModal(BuildContext context,
    void Function(BuildContext, void Function()) modal) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        double modalWidth = MediaQuery.of(context).size.width - 804 > 650
            ? MediaQuery.of(context).size.width - 804
            : 650;
        double modalHeight = MediaQuery.of(context).size.height - 104 > 400
            ? MediaQuery.of(context).size.height - 104
            : 400;
        print(modalWidth);

        bool buttonActive = false;

        var buttonBG = const LinearGradient(
            colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)]);

        List<Operator> allowedOperators =
            List.from(l<DifficultyManager>().operatii.allowedOperators);
        List<TextEditingController> controllers = List.generate(3, (index) {
          return TextEditingController();
        });

        return StatefulBuilder(builder: (context, setState) {
          var text1 = controllers[0].value.text;
          var text2 = controllers[1].value.text;
          var text3 = controllers[2].value.text;

          buttonActive = false;

          if (text1.isNotEmpty) buttonActive = true;
          if (text2.isNotEmpty) buttonActive = true;
          if (text3.isNotEmpty) buttonActive = true;

          for (var operator
              in l<DifficultyManager>().operatii.allowedOperators) {
            if (allowedOperators.contains(operator) == false)
              buttonActive = true;
          }

          for (var operator in allowedOperators) {
            if (l<DifficultyManager>()
                    .operatii
                    .allowedOperators
                    .contains(operator) ==
                false) buttonActive = true;
          }

          if (text1.isNotEmpty) {
            int.tryParse(text1) ?? (buttonActive = false);
          }
          if (text2.isNotEmpty) {
            int.tryParse(text2) ?? (buttonActive = false);
          }
          if (text3.isNotEmpty) {
            int.tryParse(text3) ?? (buttonActive = false);
          }
          if (allowedOperators.isEmpty) {
            buttonActive = false;
          }

          if (buttonActive == false) {
            buttonBG = const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF878c98), Color(0xAA878c98)]);
          } else if (buttonBG ==
              const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF878c98), Color(0xAA878c98)])) {
            buttonBG = const LinearGradient(
                colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)]);
          }

          return Dialog(
              // insetPadding: const EdgeInsets.symmetric(vertical: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 2, left: 30, right: 30, top: 25),
                  width: modalWidth,
                  height: modalHeight,
                  child: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          const Icon(
                            IconlyLight.close_square,
                            color: Color(0x00FEFEFE),
                            size: 36,
                          ),
                          const Expanded(child: SizedBox()),
                          Center(
                            child: Text(
                              "Configurare Dificultate",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: const Color(0xFFFEFEFE),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              40),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              IconlyLight.close_square,
                              color: Color(0xFFFEFEFE),
                              size: 36,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ]),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: modalWidth / 2,
                                child: Text("Valoarea minimă a numerelor: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                65)),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                  width: modalWidth / 5,
                                  child: TextField(
                                      onChanged: (_) {
                                        setState(() {});
                                      },
                                      controller: controllers[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(fontSize: modalWidth / 40),
                                      decoration: InputDecoration(
                                          hintText: l<DifficultyManager>()
                                              .operatii
                                              .lowLimit
                                              .toString(),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFF5D69BE))))))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: modalWidth / 2,
                                child: Text("Valoarea maximă a numerelor: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                65)),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                  width: modalWidth / 5,
                                  child: TextField(
                                      onChanged: (_) => setState(() {}),
                                      controller: controllers[1],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(fontSize: modalWidth / 40),
                                      decoration: InputDecoration(
                                          hintText: l<DifficultyManager>()
                                              .operatii
                                              .maxLimit
                                              .toString(),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFF5D69BE))))))
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: modalWidth / 2,
                                child: Text(
                                    "Adâncimea maximă (aprox. nr. maxim de paranteze unele în altele): ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                65)),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                  width: modalWidth / 5,
                                  child: TextField(
                                      onChanged: (_) => setState(() {}),
                                      controller: controllers[2],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(fontSize: modalWidth / 40),
                                      decoration: InputDecoration(
                                          hintText: l<DifficultyManager>()
                                              .operatii
                                              .depth
                                              .toString(),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFF5D69BE))))))
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: modalWidth / 2,
                            child: Text("Operaţii permise:",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                65)),
                          ),
                          Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Checkbox(
                                      splashRadius: 15,
                                      checkColor: const Color(0xFF000000),
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return const Color(0xFFFF9C60);
                                      }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      value: allowedOperators
                                          .contains(Operator.plus),
                                      onChanged: (_) {
                                        setState(() {
                                          if (allowedOperators
                                              .contains(Operator.plus)) {
                                            allowedOperators
                                                .remove(Operator.plus);
                                          } else {
                                            allowedOperators.add(Operator.plus);
                                          }
                                          print(allowedOperators);
                                        });
                                      }),
                                  Text(
                                    "Adunare",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Checkbox(
                                      splashRadius: 15,
                                      checkColor: const Color(0xFF000000),
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return const Color(0xFFFF9C60);
                                      }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      value: allowedOperators
                                          .contains(Operator.minus),
                                      onChanged: (_) {
                                        setState(() {
                                          if (allowedOperators
                                              .contains(Operator.minus)) {
                                            allowedOperators
                                                .remove(Operator.minus);
                                          } else {
                                            allowedOperators
                                                .add(Operator.minus);
                                          }
                                          print(allowedOperators);
                                        });
                                      }),
                                  Text(
                                    "Scădere",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(),
                                  ),
                                  const Expanded(child: SizedBox()),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Checkbox(
                                      splashRadius: 15,
                                      checkColor: const Color(0xFF000000),
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return const Color(0xFFFF9C60);
                                      }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      value: allowedOperators
                                          .contains(Operator.mul),
                                      onChanged: (_) {
                                        setState(() {
                                          if (allowedOperators
                                              .contains(Operator.mul)) {
                                            allowedOperators
                                                .remove(Operator.mul);
                                          } else {
                                            allowedOperators.add(Operator.mul);
                                          }
                                          print(allowedOperators);
                                        });
                                      }),
                                  Text(
                                    "Înmulţire",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Checkbox(
                                      splashRadius: 15,
                                      checkColor: const Color(0xFF000000),
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return const Color(0xFFFF9C60);
                                      }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      value: allowedOperators
                                          .contains(Operator.div),
                                      onChanged: (_) {
                                        setState(() {
                                          if (allowedOperators
                                              .contains(Operator.div)) {
                                            allowedOperators
                                                .remove(Operator.div);
                                          } else {
                                            allowedOperators.add(Operator.div);
                                          }
                                          print(allowedOperators);
                                        });
                                      }),
                                  Text(
                                    "Împărţire",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(),
                                  ),
                                  const Expanded(child: SizedBox()),
                                ])
                          ])
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: modalWidth / 5,
                      height: modalHeight / 15,
                      child: MouseRegion(
                          onExit: (_) {
                            if (!buttonActive) return;
                            setState(() {
                              buttonBG = const LinearGradient(
                                colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );
                            });
                          },
                          onEnter: (_) {
                            if (!buttonActive) return;
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
                                print(buttonActive);
                                if (!buttonActive) return;
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

                                ///TODO(wowvain-dev): BUTTONFUNCTIONALITY
                                if (text1.isNotEmpty) {
                                  l<DifficultyManager>().operatii.lowLimit =
                                      int.parse(text1);
                                }

                                if (text2.isNotEmpty) {
                                  l<DifficultyManager>().operatii.maxLimit =
                                      int.parse(text2);
                                }

                                if (text3.isNotEmpty) {
                                  l<DifficultyManager>().operatii.depth =
                                      int.parse(text3);
                                }

                                if (allowedOperators.isNotEmpty) {
                                  l<DifficultyManager>()
                                      .operatii
                                      .allowedOperators = allowedOperators;
                                }

                                ToastContext().init(context);
                                Toast.show(
                                    "Apăsaţi pe `Treceţi Peste` pentru a aplica schimbările făcute.",
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom,
                                    backgroundRadius: 10,
                                    backgroundColor: const Color(0xFF000000));
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
                                  child: Center(
                                    child: Text("Salvaţi",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: modalWidth / 60)),
                                  )))),
                    ),
                  ])));
        });
      });
}

void showFractionSettingsModal(BuildContext context,
    void Function(BuildContext, void Function()) modal) async {
          bool allowWhole = l<DifficultyManager>().fractii.allowWholes;
          bool allowSupraunit = !l<DifficultyManager>().fractii.onlySubunit;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        double modalWidth = MediaQuery.of(context).size.width - 804 > 650
            ? MediaQuery.of(context).size.width - 804
            : 650;
        double modalHeight = MediaQuery.of(context).size.height - 104 > 400
            ? MediaQuery.of(context).size.height - 104
            : 400;
        print(modalWidth);

        bool buttonActive = false;

        var buttonBG = const LinearGradient(
            colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)]);

        List<TextEditingController> controllers = List.generate(2, (index) {
          return TextEditingController();
        });

        return StatefulBuilder(builder: (context, setState) {
          var text1 = controllers[0].value.text;
          var text2 = controllers[1].value.text;


          buttonActive = false;

          if (text1.isNotEmpty) buttonActive = true;
          if (text2.isNotEmpty) buttonActive = true;

          if (allowSupraunit == l<DifficultyManager>().fractii.onlySubunit) {
            buttonActive = true;
          }

          if (allowSupraunit != l<DifficultyManager>().fractii.allowWholes) {
            buttonActive = true;
          }

          if (text1.isNotEmpty) {
            int.tryParse(text1) ?? (buttonActive = false);
          }
          if (text2.isNotEmpty) {
            int.tryParse(text2) ?? (buttonActive = false);
          }


          if (buttonActive == false) {
            buttonBG = const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF878c98), Color(0xAA878c98)]);
          } else if (buttonBG ==
              const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF878c98), Color(0xAA878c98)])) {
            buttonBG = const LinearGradient(
                colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)]);
          }

          return Dialog(
              // insetPadding: const EdgeInsets.symmetric(vertical: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 2, left: 30, right: 30, top: 25),
                  width: modalWidth,
                  height: modalHeight,
                  child: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          const Icon(
                            IconlyLight.close_square,
                            color: Color(0x00FEFEFE),
                            size: 36,
                          ),
                          const Expanded(child: SizedBox()),
                          Center(
                            child: Text(
                              "Configurare Dificultate",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: const Color(0xFFFEFEFE),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              40),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              IconlyLight.close_square,
                              color: Color(0xFFFEFEFE),
                              size: 36,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ]),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: modalWidth / 2,
                                        child: Text(
                                            "Valoarea minimă a numerelor: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            65)),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Container(
                                          width: modalWidth / 5,
                                          child: TextField(
                                              onChanged: (_) {
                                                setState(() {});
                                              },
                                              controller: controllers[0],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      fontSize:
                                                          modalWidth / 40),
                                              decoration: InputDecoration(
                                                  hintText:
                                                      l<DifficultyManager>()
                                                          .fractii
                                                          .lowLimit
                                                          .toString(),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF5D69BE))))))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: modalWidth / 2,
                                        child: Text(
                                            "Valoarea maximă a numerelor: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            65)),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Container(
                                          width: modalWidth / 5,
                                          child: TextField(
                                              onChanged: (_) => setState(() {}),
                                              controller: controllers[1],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      fontSize:
                                                          modalWidth / 40),
                                              decoration: InputDecoration(
                                                  hintText:
                                                      l<DifficultyManager>()
                                                          .fractii
                                                          .maxLimit
                                                          .toString(),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF5D69BE))))))
                                    ],
                                  ),
                                ]),
                          ),
                          // SizedBox(height: modalHeight / 10),
                          Container(
                            width: modalWidth / 2,
                            child: Text("Operaţii permise:",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                65)),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Permiteţi părţi întregi",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith()),
                                        const Expanded(child: SizedBox()),
                                        FlutterSwitch(
                                            value: allowWhole,
                                            onToggle: (value) {
                                              if (value == true &&
                                                  allowSupraunit == false) {
                                                ToastContext().init(context);
                                                Toast.show(
                                                    "Nu poţi folosi fracţii cu parte întreagă fără a folosi fracţii supraunitare.",
                                                    duration: Toast.lengthLong,
                                                    gravity: Toast.bottom,
                                                    backgroundRadius: 10,
                                                    backgroundColor:
                                                        const Color(
                                                            0xFF000000));
                                                return;
                                              }
                                              setState(() {
                                                allowWhole = value;
                                              });
                                            }),
                                      ]),
                                  const Expanded(child: SizedBox()),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Permiteţi fracţii supraunitare",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith()),
                                        const Expanded(child: SizedBox()),
                                        FlutterSwitch(
                                            value: allowSupraunit,
                                            onToggle: (value) {
                                              if (value == false &&
                                                  allowWhole == true) {
                                                ToastContext().init(context);
                                                Toast.show(
                                                    "Nu poţi folosi fracţii cu parte întreagă fără a folosi fracţii supraunitare.",
                                                    duration: Toast.lengthLong,
                                                    gravity: Toast.bottom,
                                                    backgroundRadius: 10,
                                                    backgroundColor:
                                                        const Color(
                                                            0xFF000000));
                                                return;
                                              }
                                              print('test');
                                              setState(() {
                                                allowSupraunit = value;
                                              });
                                            }),
                                      ]),
                                  const Expanded(child: SizedBox()),
                                ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: modalWidth / 5,
                      height: modalHeight / 15,
                      child: MouseRegion(
                          onExit: (_) {
                            if (!buttonActive) return;
                            setState(() {
                              buttonBG = const LinearGradient(
                                colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              );
                            });
                          },
                          onEnter: (_) {
                            if (!buttonActive) return;
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
                                print(buttonActive);
                                if (!buttonActive) return;
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

                                if (text1.isNotEmpty) {
                                  l<DifficultyManager>().fractii.lowLimit =
                                      int.parse(text1);
                                }

                                if (text2.isNotEmpty) {
                                  l<DifficultyManager>().fractii.maxLimit =
                                      int.parse(text2);
                                }

                                l<DifficultyManager>().fractii.allowWholes = allowWhole;
                                l<DifficultyManager>().fractii.onlySubunit = !allowSupraunit;

                                ToastContext().init(context);
                                Toast.show(
                                    "Apăsaţi pe `Treceţi Peste` pentru a aplica schimbările făcute.",
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom,
                                    backgroundRadius: 10,
                                    backgroundColor: const Color(0xFF000000));
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
                                  child: Center(
                                    child: Text("Salvaţi",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: modalWidth / 60)),
                                  )))),
                    ),
                  ])));
        });
      });
}
