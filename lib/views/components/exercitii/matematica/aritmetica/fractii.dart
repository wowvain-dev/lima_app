import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fraction/fraction.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/classes/difficulty_manager.dart';
import 'package:lima/models/classes/progress_manager.dart';
import 'package:lima/models/classes/storage_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/components/help_section/help_section.dart';
import 'package:lima/views/components/skip_button/skip_button.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';

import '../../../verif_button/verif_button.dart';

class Fractii extends StatefulWidget {
  Fractii({
    Key? key,
    required this.level
  });

  int level;

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
    var progress = ProgressStorage.levels[widget.level-1].matematica.parts["aritmetica"]!.parts["fractii"]!;
    print(size.height);
    if (size.height > 950) {
      return Container(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: size.height / 7,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                VerifButton(
                                    height: size.height / 15,
                                    width: size.width / 7,
                                    onPressed: () {
                                      var value = int.parse(controller1.text) / int.parse(controller2.text);

                                      /// TODO(wowvain-dev): MAKE ALL POSSIBLE CHECKS FOR THE VALUE INSIDE THE TextFields
                                      /// TODO(wowvain-dev): TRY ADDING TEXTURE FOR THE SLICES

                                      if (value == frac!.toDouble()) {
                                        if (progress.current < progress.total) {
                                          progress.current += 1;
                                          print("${progress.current}/${progress.total}");
                                        } else {
                                          if (progress.current > progress.total) {
                                            Navigator.pop(context);
                                            context.router.replace(
                                                ExerciseWrapper(
                                                    exercise: Fractii(level: widget.level),
                                                    modal: showFractiiModal
                                                ));
                                          }
                                        }
                                        Navigator.pop(context);
                                        context.router.replace(
                                            ExerciseWrapper(
                                                exercise: Fractii(level: widget.level),
                                                modal: showFractiiModal
                                            ));
                                      } else {
                                        showTryAgainModal(context);
                                      }
                                    },
                                    child: Text("VERIFICĂ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: size.width / 60))),
                                SkipButton(
                                    modal: showFractiiModal,
                                    exercise: Fractii(level: widget.level)
                                ),
                                const Expanded(child: SizedBox()),
                              ]),
                        ),
                      ),
                    ]
                  )
                ),
                HelpSection(showAnswer: () {
                  print("pressed");
                  setState(() {
                    controller1.text = frac!.numerator.toString();
                    controller2.text = frac!.denominator.toString();
                  });
                }, modal: showFractiiModal)
              ]));
    } else {
      return Container(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200, height: 200,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: CustomPaint(painter: PizzaPainter(fraction: frac!)),
                      ),
                    ),
                    const SizedBox(width: 100),
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

                  ]
                ),
                const Expanded(child: SizedBox()),
                Container(
                  height: size.height / 6,
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          VerifButton(
                              height: size.height / 15,
                              width: size.width / 7,
                              onPressed: () {
                                var value = int.parse(controller1.text) / int.parse(controller2.text);

                                /// TODO(wowvain-dev): MAKE ALL POSSIBLE CHECKS FOR THE VALUE INSIDE THE TextFields
                                /// TODO(wowvain-dev): TRY ADDING TEXTURE FOR THE SLICES

                                if (value == frac!.toDouble()) {
                                  if (progress.current < progress.total) {
                                    progress.current += 1;
                                    print("${progress.current}/${progress.total}");
                                  } else {
                                    if (progress.current > progress.total) {
                                      Navigator.pop(context);
                                      context.router.replace(
                                          ExerciseWrapper(
                                              exercise: Fractii(level: widget.level),
                                              modal: showFractiiModal
                                          ));
                                    }
                                  }
                                  Navigator.pop(context);
                                  context.router.replace(
                                      ExerciseWrapper(
                                          exercise: Fractii(level: widget.level),
                                          modal: showFractiiModal
                                      ));
                                } else {
                                  showTryAgainModal(context);
                                }
                              },
                              child: Text("VERIFICĂ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: size.width / 60))),
                          SkipButton(modal: showFractiiModal, exercise: Fractii(level: widget.level)),
                          const Expanded(child: SizedBox()),
                        ]),
                  ),
                ),
                const Expanded(child: SizedBox()),
                HelpSection(showAnswer: () {
                  print("pressed");
                  setState(() {
                    controller1.text = frac!.numerator.toString();
                    controller2.text = frac!.denominator.toString();
                  });
                }, modal: showFractiiModal)
              ]));
    }
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
