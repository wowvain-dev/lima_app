import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';

import 'package:lima/models/expression_tree.dart';

class Operatii extends StatefulWidget {
  Operatii({
    Key? key,
  });

  @override
  // ignore: no_logic_in_create_state
  createState() => _OperatiiState();
}

class _OperatiiState extends State<Operatii> {
  _OperatiiState();

  List<Operator> sign = List.empty();

  int start = 0, end = 0;
  int depth = 0;

  int a = 0, b = 0;
  Color accent = const Color(0x00000000);

  Color skip = const Color(0xFFaaaaaa);

  FocusNode f_node = FocusNode();
  FocusNode p_node = FocusNode();

  TextEditingController controller = TextEditingController();

  LinearGradient? buttonBG;

  ExpressionTree tree = ExpressionTree();

  @override
  void initState() {
    var props = l<DifficultyManager>().operatii;
    sign = props.allowedOperators;
    print(sign);
    start = props.lowLimit;
    end = props.maxLimit;
    depth = props.depth;
    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

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

    return Container(
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
                width: (size.width / 20) *
                    (ExpressionTree.evaluate(tree.root).toString().length),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          if (controller.text ==
                              ExpressionTree.evaluate(tree.root).toString()) {
                            print('BRAVO');
                            Navigator.pop(context);
                            context.router.replace(ExerciseWrapper(
                                exercise: Operatii(),
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
                GestureDetector(
                  onTap: () {
                    context.router.push(ExerciseWrapper(
                        exercise: Operatii(), modal: showOperatiiModal));
                  },
                  child: MouseRegion(
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
                    child: AnimatedContainer(
                      margin: const EdgeInsets.only(top: 20),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      child: Text("Treceţi Peste",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: skip)),
                    ),
                  ),
                )
              ],
            ),
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
    ));
  }
}
