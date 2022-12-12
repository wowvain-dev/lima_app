/// Flutter
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/views/components/exercise_card/exercise_card.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/fractii.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/operatii.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/ordine.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion/motion.dart';

class Aritmetica1View extends StatefulWidget {
  Aritmetica1View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Aritmetica1ViewState();
}

class Aritmetica1ViewState extends State<Aritmetica1View> {
  Aritmetica1ViewState({Key? key});

  bool b_card1 = false;
  bool b_card2 = false;
  bool b_card3 = false;
  bool b_card4 = false;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double cardWidth = constraints.maxWidth / 3.5 + 20;
      double cardHeight = constraints.maxHeight / 4 + 20;
      return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            b_card1 = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            b_card1 = false;
                          });
                        },
                        child: b_card1 == false
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                width: cardWidth,
                                height: cardHeight,
                                child: ExerciseCard(
                                    label: 'Operaţii',
                                    icon: Iconsax.add,
                                    onStart: () =>
                                        print('adunare si scadere - start'),
                                    ),
                              )
                            : Motion(
                                borderRadius: BorderRadius.circular(10),
                                glare: const GlareConfiguration(maxOpacity: 0),
                                shadow: ShadowConfiguration(
                                    color: Colors.pink[300]!),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: cardWidth,
                                  height: cardHeight,
                                  child: ExerciseCard(
                                      label: 'Operaţii',
                                      icon: Iconsax.add,
                                      onStart: () {
                                        setState(() {
                                          opacity = 0;
                                        });
                                        context.router.replace(ExerciseWrapper(
                                            exercise:
                                                Operatii(),
                                            modal: showOperatiiModal
                                             ));
                                      },
                                      onHelp: showOperatiiModal),
                                ),
                              ),
                      ),
                      SizedBox(width: constraints.maxWidth / 20),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            b_card2 = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            b_card2 = false;
                          });
                        },
                        child: b_card2 == false
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                width: cardWidth,
                                height: cardHeight,
                                child: ExerciseCard(
                                    label: 'Fracţii',
                                    icon: LineIcons.divide,
                                    onStart: () {
                                        setState(() {
                                          opacity = 0;
                                        });
                                        context.router.replace(ExerciseWrapper(
                                            exercise:
                                                Fractii(),
                                            modal: showFractiiModal
                                             ));
                                    },
                              ))
                            : Motion(
                                borderRadius: BorderRadius.circular(10),
                                glare: const GlareConfiguration(maxOpacity: 0),
                                shadow: const ShadowConfiguration(
                                    color: Colors.orangeAccent),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: cardWidth,
                                  height: cardHeight,
                                  child: ExerciseCard(
                                      label: 'Fracţii',
                                      icon: LineIcons.divide,
                                      onStart: () {
                                        setState(() {
                                          opacity = 0;
                                        });
                                        context.router.replace(ExerciseWrapper(
                                            exercise:
                                                Fractii(),
                                            modal: showFractiiModal
                                             ));
                                      },
                                      ),
                                ),
                              ),
                      ),
                    ]),
                SizedBox(height: constraints.maxWidth / 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            b_card3 = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            b_card3 = false;
                          });
                        },
                        child: b_card3 == false
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                width: cardWidth,
                                height: cardHeight,
                                child: ExerciseCard(
                                    label: 'Ordine de şiruri',
                                    icon: Iconsax.arrow_3,
                                    onStart: () => print('ordine - start'),
                                    ),
                              )
                            : Motion(
                                borderRadius: BorderRadius.circular(10),
                                glare: const GlareConfiguration(maxOpacity: 0),
                                shadow: ShadowConfiguration(
                                    color: Colors.green[400]!),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: cardWidth,
                                  height: cardHeight,
                                  child: ExerciseCard(
                                      label: 'Ordine de şiruri',
                                      icon: Iconsax.arrow_3,
                                      onStart: () {
                                        setState(() {
                                          opacity = 0;
                                        });
                                        context.router.replace(ExerciseWrapper(
                                            exercise:
                                                OrdiniSiruri(),
                                            modal: showFractiiModal
                                             ));
                                      },
                                      ),
                                ),
                              ),
                      ),
                      SizedBox(width: constraints.maxWidth / 20),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            b_card4 = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            b_card4 = false;
                          });
                        },
                        child: b_card4 == false
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                width: cardWidth,
                                height: cardHeight,
                                child: ExerciseCard(
                                    label: 'Formarea numerelor',
                                    icon: Iconsax.data,
                                    onStart: () =>
                                        print('formarea numerelor - start'),
                                        ),
                              )
                            : Motion(
                                borderRadius: BorderRadius.circular(10),
                                glare: const GlareConfiguration(maxOpacity: 0),
                                shadow: ShadowConfiguration(
                                    color: Colors.blue[200]!),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: cardWidth,
                                  height: cardHeight,
                                  child: ExerciseCard(
                                      label: 'Formarea numerelor',
                                      icon: Iconsax.data,
                                      onStart: () =>
                                          print('formarea numerelor - start'),
                                          ),
                                ),
                              ),
                      ),
                    ])
              ]));
    });
  }
}

void showOperatiiModal(BuildContext context,
   void Function() callback) {
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        contentPadding: const EdgeInsets.only(top: 10),
        title: null, 
        content: Container(
          height: 500, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3), 
                  child: Center(
                    child: Text("Lamo"), 
                  )
                )
              )
            ]
          )
        )
      );
    }
  );
}

void showFractiiModal(BuildContext context,
   void Function() callback) {
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        contentPadding: const EdgeInsets.only(top: 10),
        title: null, 
        content: Container(
          height: 500, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3), 
                  child: Center(
                    child: Text("Lamo"), 
                  )
                )
              )
            ]
          )
        )
      );
    }
  );
}

void showOrdiniModal(BuildContext context,
    void Function() callback) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.only(top: 10),
            title: null,
            content: Container(
                height: 500,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Center(
                                child: Text("Lamo"),
                              )
                          )
                      )
                    ]
                )
            )
        );
      }
  );
}
