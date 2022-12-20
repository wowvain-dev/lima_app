import 'dart:math';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:toast/toast.dart';
import 'package:tuple/tuple.dart';

class Formare extends StatefulWidget {
  Formare({Key? key});

  @override
  // ignore: no_logic_in_create_state
  createState() => _FormareState();
}

class _FormareState extends State<Formare> {
  _FormareState();

  LinearGradient? buttonBG;

  int number = 0;

  // final LinearGradient plusDefault = const LinearGradient(
  //     colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight);
  // final LinearGradient plusHover = const LinearGradient(
  //     colors: [Color(0xFF757F9A - 0x00222222), Color(0xFFD7DDE8 - 0x00222222)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight);
  //
  // final LinearGradient minusDefault = const LinearGradient(colors: [
  //   Color(0xFFDE6262),
  //   Color(0xFFFFB88C),
  // ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  //
  // final LinearGradient minusHover = const LinearGradient(colors: [
  //   Color(0xFFDE6262 - 0x00222222),
  //   Color(0xFFFFB88C - 0x00222222),
  // ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  final LinearGradient mainPoleColor = const LinearGradient(
    colors: [Color(0xFF1c94b3), Color(0xFF1c94b3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );

  final LinearGradient plusDefault = const LinearGradient(
      colors: [Color(0xFF73c4d9), Color(0xFF73c4d9)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  final LinearGradient plusHover = const LinearGradient(
      colors: [Color(0xFF73c4d9 - 0x00111111), Color(0xFF73c4d9 - 0x00111111)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  final LinearGradient minusDefault = const LinearGradient(colors: [
    Color(0xFF166b82),
    Color(0xFF166b82),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  final LinearGradient minusHover = const LinearGradient(colors: [
    Color(0xFF166b82 - 0x00111111),
    Color(0xFF166b82 - 0x00111111),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  List<Tuple2<LinearGradient, LinearGradient>> buttonColors =
      List.empty(growable: true);

  int m = 0;
  int s = 0;
  int z = 0;
  int u = 0;

  FormareType type = l<DifficultyManager>().formare.type;

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
    if (type == FormareType.U) {
      number = Random().nextInt(10);
      buttonColors.clear();
      buttonColors.add(Tuple2(plusDefault, minusDefault));
    }
    if (type == FormareType.ZU) {
      number = Random().nextInt(90) + 10;
      buttonColors.clear();
      buttonColors.addAll(List.filled(2, Tuple2(plusDefault, minusDefault)));
    }
    if (type == FormareType.SZU) {
      number = Random().nextInt(900) + 100;
      buttonColors.clear();
      buttonColors.addAll(List.filled(3, Tuple2(plusDefault, minusDefault)));
    }
    if (type == FormareType.MSZU) {
      number = Random().nextInt(9000) + 1000;
      buttonColors.clear();
      buttonColors.addAll(List.filled(4, Tuple2(plusDefault, minusDefault)));
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const Expanded(child: SizedBox()),
          Text(number.toString(), style: Theme.of(context).textTheme.headline3),
          const Expanded(child: SizedBox()),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // ((){
            if (type == FormareType.MSZU) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(children: [
                  Container(
                      height: 200,
                      child: CustomPaint(painter: BarPainter(number: m))),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        gradient: mainPoleColor),
                    child: Center(
                        child: Text("M",
                            style: Theme.of(context).textTheme.headline6)),
                  ),
                  Row(children: [
                    MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            buttonColors[3] =
                                Tuple2(plusHover, buttonColors[3].item2);
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            buttonColors[3] =
                                Tuple2(plusDefault, buttonColors[3].item2);
                          });
                        },
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ToastContext().init(context);
                                if (m == 9) {
                                  Toast.show(
                                      "Nu poţi adăuga mai mult de 9 bile be o tijă.",
                                      duration: Toast.lengthLong,
                                      gravity: Toast.bottom,
                                      backgroundRadius: 10,
                                      backgroundColor: const Color(0xFF000000));
                                  return;
                                }
                                m++;
                              });
                            },
                            child: AnimatedContainer(
                                width: 75,
                                height: 40,
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    gradient: buttonColors[0].item1),
                                child: Center(
                                  child: Icon(LineIcon.plus().icon))))),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          buttonColors[3] =
                              Tuple2(buttonColors[3].item1, minusHover);
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          buttonColors[3] =
                              Tuple2(buttonColors[3].item1, minusDefault);
                        });
                      },
                      child: GestureDetector(
                        onTap: () => setState(() {
                          ToastContext().init(context);
                          if (m == 0) {
                            Toast.show("Nu mai sunt bile de scos de pe tijă.",
                                gravity: Toast.bottom,
                                duration: Toast.lengthLong,
                                backgroundRadius: 10,
                                backgroundColor: const Color(0xFF000000));
                            return;
                          }
                          m--;
                        }),
                        child: AnimatedContainer(
                            width: 75,
                            height: 40,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                ),
                                gradient: buttonColors[3].item2),
                            child: Center(
                              child: Icon(LineIcon.minus().icon))),
                      ),
                    )
                  ])
                ]),
              )
            ],
            if (type == FormareType.MSZU || type == FormareType.SZU) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(children: [
                  Container(
                      height: 200,
                      child: CustomPaint(painter: BarPainter(number: s))),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        gradient: mainPoleColor),
                    child: Center(
                        child: Text("S",
                            style: Theme.of(context).textTheme.headline6)),
                  ),
                  Row(children: [
                    MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            buttonColors[2] =
                                Tuple2(plusHover, buttonColors[2].item2);
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            buttonColors[2] =
                                Tuple2(plusDefault, buttonColors[2].item2);
                          });
                        },
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ToastContext().init(context);
                                if (s == 9) {
                                  Toast.show(
                                      "Nu poţi adăuga mai mult de 9 bile be o tijă.",
                                      duration: Toast.lengthLong,
                                      gravity: Toast.bottom,
                                      backgroundRadius: 10,
                                      backgroundColor: const Color(0xFF000000));
                                  return;
                                }
                                s++;
                              });
                            },
                            child: AnimatedContainer(
                                width: 75,
                                height: 40,
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    gradient: buttonColors[0].item1),
                                child: Center(
                                    child: Icon(LineIcon.plus().icon))))),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          buttonColors[2] =
                              Tuple2(buttonColors[2].item1, minusHover);
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          buttonColors[2] =
                              Tuple2(buttonColors[2].item1, minusDefault);
                        });
                      },
                      child: GestureDetector(
                        onTap: () => setState(() {
                          ToastContext().init(context);
                          if (s == 0) {
                            Toast.show("Nu mai sunt bile de scos de pe tijă.",
                                gravity: Toast.bottom,
                                duration: Toast.lengthLong,
                                backgroundRadius: 10,
                                backgroundColor: const Color(0xFF000000));
                            return;
                          }
                          s--;
                        }),
                        child: AnimatedContainer(
                            width: 75,
                            height: 40,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                ),
                                gradient: buttonColors[0].item2),
                            child: Center(
                              child: Icon(LineIcon.minus().icon))),
                      ),
                    )
                  ])
                ]),
              ),
            ],
            if (type == FormareType.MSZU ||
                type == FormareType.SZU ||
                type == FormareType.ZU) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(children: [
                  Container(
                      height: 200,
                      child: CustomPaint(painter: BarPainter(number: z))),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        gradient: mainPoleColor),
                    child: Center(
                        child: Text("Z",
                            style: Theme.of(context).textTheme.headline6)),
                  ),
                  Row(children: [
                    MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            buttonColors[1] =
                                Tuple2(plusHover, buttonColors[1].item2);
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            buttonColors[1] =
                                Tuple2(plusDefault, buttonColors[1].item2);
                          });
                        },
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ToastContext().init(context);
                                if (z == 9) {
                                  Toast.show(
                                      "Nu poţi adăuga mai mult de 9 bile be o tijă.",
                                      duration: Toast.lengthLong,
                                      gravity: Toast.bottom,
                                      backgroundRadius: 10,
                                      backgroundColor: const Color(0xFF000000));
                                  return;
                                }
                                z++;
                              });
                            },
                            child: AnimatedContainer(
                                width: 75,
                                height: 40,
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    gradient: buttonColors[1].item1),
                                child: Center(
                                    child: Icon(LineIcon.plus().icon)
                                )))),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          buttonColors[1] =
                              Tuple2(buttonColors[1].item1, minusHover);
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          buttonColors[1] =
                              Tuple2(buttonColors[1].item1, minusDefault);
                        });
                      },
                      child: GestureDetector(
                        onTap: () => setState(() {
                          ToastContext().init(context);
                          if (z == 0) {
                            Toast.show("Nu mai sunt bile de scos de pe tijă.",
                                gravity: Toast.bottom,
                                duration: Toast.lengthLong,
                                backgroundRadius: 10,
                                backgroundColor: const Color(0xFF000000));
                            return;
                          }
                          z--;
                        }),
                        child: AnimatedContainer(
                            width: 75,
                            height: 40,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                ),
                                gradient: buttonColors[1].item2),
                            child: Center(
                              child: Icon(LineIcon.minus().icon))),
                      ),
                    )
                  ])
                ]),
              ),
            ],
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(children: [
                Container(
                    height: 200,
                    child: CustomPaint(painter: BarPainter(number: u))),
                Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      gradient: mainPoleColor),
                  child: Center(
                      child: Text("U",
                          style: Theme.of(context).textTheme.headline6)),
                ),
                Row(children: [
                  MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          buttonColors[0] =
                              Tuple2(plusHover, buttonColors[0].item2);
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          buttonColors[0] =
                              Tuple2(plusDefault, buttonColors[0].item2);
                        });
                      },
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              ToastContext().init(context);
                              if (u == 9) {
                                Toast.show(
                                    "Nu poţi adăuga mai mult de 9 bile be o tijă.",
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom,
                                    backgroundRadius: 10,
                                    backgroundColor: const Color(0xFF000000));
                                return;
                              }
                              u++;
                            });
                          },
                          child: AnimatedContainer(
                              width: 75,
                              height: 40,
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  gradient: buttonColors[0].item1),
                              child:
                                  Center(child: Icon(LineIcon.plus().icon))))),
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        buttonColors[0] =
                            Tuple2(buttonColors[0].item1, minusHover);
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        buttonColors[0] =
                            Tuple2(buttonColors[0].item1, minusDefault);
                      });
                    },
                    child: GestureDetector(
                        onTap: () => setState(() {
                              ToastContext().init(context);
                              if (u == 0) {
                                Toast.show(
                                    "Nu mai sunt bile de scos de pe tijă.",
                                    gravity: Toast.bottom,
                                    duration: Toast.lengthLong,
                                    backgroundRadius: 10,
                                    backgroundColor: const Color(0xFF000000));
                                return;
                              }
                              u--;
                            }),
                        child: AnimatedContainer(
                            width: 75,
                            height: 40,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                ),
                                gradient: buttonColors[0].item2),
                            child: Center(child: Icon(LineIcon.minus().icon)))),
                  )
                ])
              ]),
            )
          ]),
          const Expanded(child: SizedBox()),
          Container(
            height: 100,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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

                              var value = m * 1000 + s * 100 + z * 10 + u;

                              /// TODO(wowvain-dev): MAKE ALL POSSIBLE CHECKS FOR THE VALUE INSIDE THE TextFields
                              /// TODO(wowvain-dev): TRY ADDING TEXTURE FOR THE SLICES

                              if (value == number) {
                                print('BRAVO');
                                Navigator.pop(context);
                                context.router.replace(ExerciseWrapper(
                                    exercise: Formare(),
                                    modal: showFormareModal));
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
                                        .copyWith(
                                            fontSize: size.width / 60))))),
                    GestureDetector(
                      onTap: () {
                        context.router.push(ExerciseWrapper(
                            exercise: Formare(), modal: showFormareModal));
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
                const VerticalDivider(
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

class BarPainter extends CustomPainter {
  BarPainter({required this.number});

  int number;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(pi);
    canvas.translate(0, -200);
    var brush1 = Paint()
      ..color = const Color(0xFFfefefe)
      ..style = PaintingStyle.stroke;

    var brush2 = Paint()
      ..color = const Color(0xFFfefefe)
      ..style = PaintingStyle.fill;

    canvas.drawLine(const Offset(0, 0), const Offset(0, 220), brush1);
    for (int i = 12; i < 12 + number * 24; i += 24) {
      canvas.drawCircle(
          Offset(0, double.tryParse(i.toString()) ?? 0), 12, brush2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
