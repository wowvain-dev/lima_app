import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart' as routes;
import 'package:lima/models/classes/difficulty_manager.dart';
import 'package:lima/models/classes/storage_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/components/skip_button/skip_button.dart';
import 'package:lima/views/components/verif_button/verif_button.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:lima/views/components/help_section/help_section.dart';

import 'package:lima/models/classes/expression_tree.dart';
import 'package:toast/toast.dart';

import '../../../custom_icon_button/custom_icon_button.dart';

class Operatii extends StatefulWidget {
  Operatii({
    Key? key,
    required this.level
  });

  int level;

  @override
  // ignore: no_logic_in_create_state
  createState() => _OperatiiState();
}

class _OperatiiState extends State<Operatii> with TickerProviderStateMixin {
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

  FocusNode enterNode = FocusNode();

  AnimationController? _controller1;
  AnimationController? _controller2;
  Animation<Color?>? animation1;
  Animation<Color?>? animation2;

  bool _usedCheat = false;

  @override
  void initState() {
    super.initState();
    var props = l<DifficultyManager>().operatii;
    sign = props.allowedOperators;
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

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation1 = ColorTween(
      begin: Colors.grey,
      end: Colors.white,
    ).animate(_controller1!)
      ..addListener(() {
        setState(() {});
      });

    animation2 = ColorTween(
      begin: Colors.grey,
      end: Colors.white,
    ).animate(_controller2!)
      ..addListener(() {
        setState(() {});
      });

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

    enterNode.requestFocus();

    super.initState();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var progress = ProgressStorage.levels[widget.level-1].matematica.parts["aritmetica"]!.parts["operatii"]!;
    return Focus(
      focusNode: enterNode,
      child: Container(
          // width: size.width / 1.5,
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 75,
              margin: const EdgeInsets.only(right: 25),
              child: CustomIconButton(
                duration: const Duration(milliseconds: 100),
                onPressed: () => showSettingsModal(widget, context,
                    showOperatiiModal),
                icon: Iconsax.setting_2,
                size: 0.025 * MediaQuery.of(context).size.width,
                sizeEnd: 0.03 * MediaQuery.of(context).size.width,
                background: const Color(0xFFaaaaaa),
                backgroundEnd: const Color(0xFFfefefe),
                rotate: false,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
              ]),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerifButton(
                      height: size.height / 15,
                      width: size.width / 7,
                      onPressed: () {
                        if (controller.text ==
                              ExpressionTree.evaluate(tree.root).toString()) {
                            if (_usedCheat) {
                              context.router.pop(context);
                              context.router.replace(
                                  routes.Operatii(level: 1)
                              );
                              return;
                            }
                            if (progress.current < progress.total) {
                              progress.current += 1;
                              print("${progress.current}/${progress.total}");
                            } else {
                              if (progress.current > progress.total) {
                                context.router.pop(context);
                                context.router.replace(
                                    routes.Operatii(level: widget.level)
                                );
                                return;
                              }
                              progress.current += 1;
                              // TODO: add CONFETII for completing the exercise
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
                            context.router.pop(context);
                            context.router.replace(
                                routes.Operatii(level: 1));
                          } else {
                            showTryAgainModal(context);
                          }
            },
                child:
                    Text("VERIFICĂ",
                        style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontSize: size.width / 60))),
                  const SizedBox(height: 15),
                  SkipButton(modal: showOperatiiModal,
                      exercise: routes.Operatii(level: widget.level))
                ],
              ),
            ),
          ),
          HelpSection(
              showAnswer: () {
                controller.text = ExpressionTree.evaluate(tree.root).toString();
                _usedCheat = true;
              },
              modal: showOperatiiModal)
        ],
      )),
    );
  }
}
