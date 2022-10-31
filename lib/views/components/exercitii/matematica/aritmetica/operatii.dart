import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';

enum Sign {
  plus, 
  minus, 
  mul, 
  div,
}

extension SignPrinting on Sign {
  String get symbol {
    switch(this) {
      case Sign.plus: 
        return '+';
      case Sign.minus: 
        return '-';
      case Sign.mul: 
        return '*';
      case Sign.div: 
        return '/';
    }
  }
}

/// Binary Tree node describing a mathematical expression where every
/// non-leaf node contains a sign and every leaf contains a number.
class ExpressionNode{
  ExpressionNode(this.sign, this.value);

  /// The sign of this node or null.
  Sign? sign;

  /// The value of this node or null.
  int? value;

  ExpressionNode? left;
  ExpressionNode? right;

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
    ExpressionNode? node, [
      String top = '', 
      String root = '', 
      String bottom = '', 
    ]
  ) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.left == null && node.right == null) {
      return '$root ${node.value ?? node.sign!.symbol}\n';
    } 
    final a = _diagram(
      node.right, 
      '$top ', 
      '$top┌──',
      '$top│ ',
    );
    final b = '$root${node.value ?? node.sign!.symbol}\n';
    final c = _diagram(
      node.left, 
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );
    
    return '\n$a$b$c';
  }
}

class Operatii extends StatefulWidget {
  Operatii({
    Key? key,
    required this.difficultyLevel,
  });

  /// The difficulty level of this exercise
  int difficultyLevel;

  @override
  // ignore: no_logic_in_create_state
  createState() => _OperatiiState(level: difficultyLevel);
}

class _OperatiiState extends State<Operatii> {
  _OperatiiState({required this.level});

  int level;

  /// 1 +
  /// 2 -
  /// 3 *
  /// 4 /
  int sign = 0;

  int start = 0, end = 0;

  int a = 0, b = 0;
  Color accent = const Color(0x00000000);

  FocusNode f_node = FocusNode();
  FocusNode p_node = FocusNode();

  TextEditingController controller = TextEditingController();

  LinearGradient? buttonBG;

  @override
  void initState() {
    buttonBG = const LinearGradient(
      colors: [
        Color(0xFFBDC3C7),
        Color(0xFF2C3E50),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    switch (level) {
      case 1:
        sign = Random().nextInt(2) + 1;
        start = 0;
        end = 100;
        break;
      case 2:
        sign = Random().nextInt(2);
        start = 0;
        end = 1000;
        break;
      case 3:
        sign = Random().nextInt(2);
        start = 0;
        end = 10000;
        break;
    }

    accent = Colors.primaries.skipWhile((value) => value.red > 150).elementAt(
        Random().nextInt(
            Colors.primaries.skipWhile((value) => value.red > 150).length));
    a = Random().nextInt(start + end - 1) + start + 1;
    b = Random().nextInt(start + min((end - a).abs(), a)) + start;

    f_node.addListener(() => setState(() {
          accent = Colors.primaries
              .skipWhile((value) => value.red > 150)
              .elementAt(Random().nextInt(Colors.primaries
                  .skipWhile((value) => value.red > 150)
                  .length));
        }));
    f_node.unfocus();

    super.initState();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    ExpressionNode root = ExpressionNode(Sign.plus, null)
      ..left = (ExpressionNode(Sign.mul, null)
        ..left = ExpressionNode(null, 7)
        ..right = (ExpressionNode(Sign.plus, null)
          ..left = ExpressionNode(null, 9) 
          ..right = ExpressionNode(null, 23)
        )
      )
      ..right = ExpressionNode(null, 3);

    print(root);

    return Focus(
      focusNode: p_node,
      onKey: (_, event) {
        if (event.data.physicalKey == PhysicalKeyboardKey.escape) {
          f_node.unfocus();
          return KeyEventResult.handled;
        }
        if (event.data.physicalKey == PhysicalKeyboardKey.enter) {
          setState(() {
            Future.delayed(Duration.zero, () {
              buttonBG = const LinearGradient(colors: [
                Color(0xFF29323c),
                Color(0xFF485563),
              ], begin: Alignment.bottomLeft, end: Alignment.topRight);
            }).whenComplete(() {
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  buttonBG = const LinearGradient(
                    colors: [
                      Color(0xFFBDC3C7),
                      Color(0xFF2C3E50),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  );
                });
              });
            });
          });
          if (sign == 1) {
            if (controller.text == (a + b).toString()) {
              print('BRAVO');
              Navigator.pop(context);
              context.router.replace(ExerciseWrapper(
                  exercise: Operatii(difficultyLevel: 1),
                  modal: showOperatiiModal));
            } else {
              showTryAgainModal(context);
            }
          }
          if (sign == 2) {
            if (controller.text == (a - b).toString()) {
              print('BRAVO');
              Navigator.pop(context);
              context.router.replace(ExerciseWrapper(
                  exercise: Operatii(difficultyLevel: 1),
                  modal: showOperatiiModal));
            } else {
              showTryAgainModal(context);
            }
          }
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        // width: size.width / 1.5,
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: GestureDetector(onTap: () => {})),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(child: GestureDetector(onTap: () => {})),
                Text(a.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: size.width / 20)),
                Text(sign == 1 ? ' + ' : (sign == 2 ? ' - ' : ''),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: size.width / 20)),
                Text(b.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: size.width / 20)),
                Text(' = ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: size.width / 20)),
                Container(
                  width: (size.width / 20) * ((a + b).toString().length),
                  child: TextField(
                      controller: controller,
                      focusNode: f_node,
                      cursorColor: accent,
                      decoration: InputDecoration(
                          hintText: f_node.hasFocus ? '' : '?',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: accent, width: 2))),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: size.width / 20)),
                ),
                // Expanded(child: GestureDetector(onTap: () => {})),
              ]),
          Expanded(
            child: Center(
              child: MouseRegion(
                  onExit: (_) {
                    setState(() {
                      buttonBG = const LinearGradient(
                        colors: [
                          Color(0xFFBDC3C7),
                          Color(0xFF2C3E50),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      );
                    });
                  },
                  onEnter: (_) {
                    setState(() {
                      buttonBG = const LinearGradient(
                        colors: [
                          Color(0xFFc79081),
                          Color(0xFFdfa579),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      );
                    });
                  },
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Future.delayed(Duration.zero, () {
                            buttonBG = const LinearGradient(
                                colors: [
                                  Color(0xFF29323c),
                                  Color(0xFF485563),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight);
                          }).whenComplete(() {
                            Future.delayed(Duration(milliseconds: 200), () {
                              setState(() {
                                buttonBG = const LinearGradient(
                                  colors: [
                                    Color(0xFFc79081),
                                    Color(0xFFdfa579),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                );
                              });
                            });
                          });
                        });
                        if (controller.text == (a + b).toString()) {
                          print('BRAVO');
                          Navigator.pop(context);
                          context.router.replace(ExerciseWrapper(
                              exercise: Operatii(difficultyLevel: 1),
                              modal: showOperatiiModal));
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
                                color: const Color(0x99000000),
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
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width / 4),
            height: size.height / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text("Ce trebuie să fac?",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey, fontSize: size.width / 60)),
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
                            color: Colors.grey, fontSize: size.width / 60)),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
