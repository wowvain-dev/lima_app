import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fraction/fraction.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';

class Fractii extends StatefulWidget {
  Fractii({
    Key? key,
  });

  @override
  // ignore: no_logic_in_create_state
  createState() => _FractiiState();
}

class _FractiiState extends State<Fractii> {
  _FractiiState();

  var f1_node = FocusNode();
  var f2_node = FocusNode();

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();

  LinearGradient? buttonBG;

  Fraction? frac;
  MixedFraction? mix_frac;

  int? start;
  int? end;
  bool? allowWholes;
  bool? onlySubunit;

  Color skip = const Color(0xFFaaaaaa);

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

    var props = l<DifficultyManager>().fractii;
    start = props.lowLimit;
    end = props.maxLimit;
    allowWholes = props.allowWholes;
    onlySubunit = true;

    f1_node.addListener(() {
      setState(() {});
    });
    f2_node.addListener(() {
      setState(() {});
    });

    f1_node.unfocus();
    f2_node.unfocus();

    /// Generate fraction
    if (onlySubunit!) {
      var a = Random().nextInt(end! - start! - 1) + start!;
      int b = 0;
      if (a == start) {
        b = start!;
      } else {
        b = Random().nextInt(a - start!) + start!;
      }

      frac = Fraction(b, a);
    } else if (!allowWholes!) {
      frac = Fraction(Random().nextInt(end! - start!) + start!,
          Random().nextInt(end! - start!) + start!);
    } else {
      mix_frac = MixedFraction(
        whole: Random().nextInt(end! - start!) + start!,
        numerator: Random().nextInt(end! - start!) + start!,
        denominator: Random().nextInt(end! - start!) + start!,
      );
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Container(
            width: 200, height: 200,
            margin: const EdgeInsets.only(bottom: 10),
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(painter: PizzaPainter(fraction: frac!)),
            ),
          ),
          const SizedBox(height: 20), 
          Container(
              width: 200,
              child: Column(children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                      cursorColor: const Color(0xFF1FC5A8),
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
                                color: Color(0xFF1FC5A8), width: 2)),
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: size.width / 40)),
                ),
                const Divider(thickness: 2, color: Color(0xFFfefefe)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                      cursorColor: const Color(0xFFC89FEB),
                      focusNode: f2_node,
                      controller: controller2,
                      decoration: InputDecoration(
                        hintText: f2_node.hasFocus ? '' : '?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color(0xFFC89FEB), width: 2)),
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: size.width / 40)),
                ),
              ])),
          const Expanded(child: SizedBox()),
          Expanded(
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
                        
                        var value = int.parse(controller1.text) / int.parse(controller2.text);

                        /// TODO(wowvain-dev): CREATE SEPARATE SMALL HEIGHT LAYOUT
                        /// TODO(wowvain-dev): MAKE ALL POSSIBLE CHECKS FOR THE VALUE INSIDE THE TextFields
                        /// TODO(wowvain-dev): TRY ADDING TEXTURE FOR THE SLICES

                        if (value == frac!.toDouble()) {
                          print ('BRAVO'); 
                          Navigator.pop(context);
                          context.router.replace(
                            ExerciseWrapper(
                              exercise: Fractii(), 
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
              GestureDetector(
                onTap: () {
                  context.router.push(ExerciseWrapper(
                      exercise: Fractii(), modal: showOperatiiModal));
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
              ),
              const Expanded(child: SizedBox()),
            ]),
          ),
          const Expanded(child: SizedBox()),
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
        ]));
  }
}

class PizzaPainter extends CustomPainter {
  PizzaPainter({required this.fraction});

  Fraction fraction;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(100, 100);
    var brush1 = Paint()
      ..color = const Color(0xFFfefefe)
      ..style = PaintingStyle.stroke;

    var brush2 = Paint()
      ..color = const Color(0xFF2a2b2a)
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(const Offset(0, 0), 100, brush1);

    List<double> angles = List.empty(growable: true);

    for (double i = 0; i < 360; i += (360 / fraction.denominator)) {
      if (i / (360 / fraction.denominator) < fraction.numerator) {
        canvas.drawArc(
            const Offset(-100, -100) & const Size(200, 200),
            i * (pi / 180),
            (360 / fraction.denominator) * (pi / 180),
            true,
            Paint()
              ..color = const Color(0xFFffffff)
              ..style = PaintingStyle.fill);
        canvas.drawLine(const Offset(0, 0),
            Offset(cos(i * (pi / 180)), sin(i * (pi / 180))) * 100, brush2);
      } else {
        canvas.drawLine(const Offset(0, 0),
            Offset(cos(i * (pi / 180)), sin(i * (pi / 180))) * 100, brush1);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
