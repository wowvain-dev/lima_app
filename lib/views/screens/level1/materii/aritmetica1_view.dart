/// Flutter
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/router.gr.dart' as routes;
import 'package:lima/models/classes/header_manager.dart';
import 'package:lima/views/components/exercise_card/exercise_card.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/formare.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/fractii.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/operatii.dart';
import 'package:lima/views/components/exercitii/matematica/aritmetica/ordine.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion/motion.dart';
import 'package:lima/views/components/header_breadcrumbs/breadcrumb_element.dart';

import '../../../../app/locator.dart';
import '../../../components/exercitii/matematica/aritmetica/formare_route.dart';

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
      double cardHeight = constraints.maxHeight / 3 + 20;
      return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          child: Container(
            color: const Color(0xFF2a2b2a),
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
                                    route: '/level1/operatii',
                                    barColor: Colors.pink[300]!,
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
                                        route: '/level1/operatii',
                                        barColor: Colors.pink[300]!,
                                        label: 'Operaţii',
                                        icon: Iconsax.add,
                                        onStart: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                          context.router.replace(
                                            routes.Operatii(level: 1)
                                            // "/level1/aritmetica/exercitii/operatii"
                                          );
                                          l<HeaderManager>().addCrumb("operatii");
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
                                    route: '/level1/fractii',
                                    barColor: Colors.orangeAccent,
                                    label: 'Fracţii',
                                      icon: LineIcons.divide,
                                      onStart: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                          context.router.replace(
                                              routes.Fractii(level: 1)
                                          );
                                          l<HeaderManager>().addCrumb("fractii");
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
                                      route: '/level1/fractii',
                                      barColor: Colors.orangeAccent,
                                        label: 'Fracţii',
                                        icon: LineIcons.divide,
                                        onStart: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                          context.router.replace(
                                              routes.Fractii(level: 1)
                                          );
                                          l<HeaderManager>().addCrumb("fractii");
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
                                    route: '/level1/siruri',
                                    barColor: Colors.green[400]!,
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
                                      route: '/level1/siruri',
                                      barColor: Colors.green[400]!,
                                        label: 'Ordine de şiruri',
                                        icon: Iconsax.arrow_3,
                                        onStart: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                          context.router.replace(
                                              routes.Siruri(level: 1)
                                          );
                                          l<HeaderManager>().addCrumb("siruri");
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
                                    route: '/level1/formare',
                                    barColor: Colors.blue[200]!,
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
                                      route: '/level1/formare',
                                      barColor: Colors.blue[200]!,
                                        label: 'Formarea numerelor',
                                        icon: Iconsax.data,
                                        onStart: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                          context.router.replace(
                                                routes.Formare(level: 1)
                                          );
                                          l<HeaderManager>().addCrumb("formare");
                                        },
                                            ),
                                  ),
                                ),
                        ),
                      ])
                ]),
          ));
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

void showFormareModal(BuildContext context,
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
