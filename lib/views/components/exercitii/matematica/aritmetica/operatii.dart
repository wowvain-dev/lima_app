import 'dart:math' hide log;
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import 'package:auto_route/auto_route.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
 
import 'package:lima/models/expression_tree.dart';
 
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


  List<Operator> sign = List.empty();

  int start = 0, end = 0;
  int depth = 0;
 
  int a = 0, b = 0;
  Color accent = const Color(0x00000000);
 
  FocusNode f_node = FocusNode();
  FocusNode p_node = FocusNode();
 
  TextEditingController controller = TextEditingController();
 
  LinearGradient? buttonBG;

  ExpressionTree tree = ExpressionTree();

  @override
  void initState() {
    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
 
    switch (level) {
      case 1:
        sign = [Operator.plus, Operator.minus, Operator.div];
        start = 0;
        end = 100;
        depth = 3;
        break;
      case 2:
        sign = [Operator.plus, Operator.minus];
        start = 0;
        end = 1000;
        depth = 3;
        break;
      case 3:
        sign = [Operator.plus, Operator.minus];
        start = 0;
        end = 10000;
        depth = 4;
        break;
    }
 
    accent = Colors.primaries.skipWhile((value) => value.red > 150).elementAt(
        Random().nextInt(
            Colors.primaries.skipWhile((value) => value.red > 150).length));

    f_node.addListener(() => setState(() {
          accent = Colors.primaries
              .skipWhile((value) => value.red > 150)
              .elementAt(Random().nextInt(Colors.primaries
                  .skipWhile((value) => value.red > 150)
                  .length));
        }));
    f_node.unfocus();

    tree = ExpressionTree.random(sign, start, end, depth, []);

    while (ExpressionTree.getDepth(tree.root) <= 1) {
      tree = ExpressionTree.randomUsingSource(tree);
    }

    print("\n\nEXPRESSIONS:\n${tree.expression}");
    print("\n\nVALUE:\n${ExpressionTree.evaluate(tree.root)}");

    super.initState();
  }
 
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
              ], begin: Alignment.topLeft, end: Alignment.bottomRight);
            }).whenComplete(() {
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  buttonBG = const LinearGradient(
                    colors: [
                      Color(0xFF5D69BE), Color(0xFFC89FEB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  );
                });
              });
            });
          });
          if (controller.text == ExpressionTree.evaluate(tree.root).toString()) {
            print('BRAVO');
            Navigator.pop(context);
            context.router.replace(ExerciseWrapper(
              exercise: Operatii(difficultyLevel: 1),
              modal: showOperatiiModal)
            );
          } else {
            showTryAgainModal(context);
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
          const Expanded(child: SizedBox()),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(child: GestureDetector(onTap: () => {})),
                Text(tree.expression,
                    style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: size.width / 20)),
                Text(' = ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: size.width / 20)),
                Container(
                  width: (size.width / 20) * (ExpressionTree.evaluate(tree.root).toString().length),
                  child: TextField(
                      autofocus: true,
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
                        colors: [ Color(0xFF5D69BE), Color(0xFFC89FEB)],
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
                        colors: [ Color(0xFF5D69BE), Color(0xFFC89FEB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight);
                          }).whenComplete(() {
                            Future.delayed(Duration(milliseconds: 200), () {
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
                        if (controller.text == ExpressionTree.evaluate(tree.root).toString()) {
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