/// Flutter
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/models/classes/header_manager.dart';
import 'package:lima/views/components/exercitii/limba%20si%20comunicare/romana/recunoastere_litere.dart';
import 'package:lima/views/components/exercitii/limba%20si%20comunicare/romana/vocale_consoane.dart';
import 'package:line_icons/line_icon.dart';
import 'package:motion/motion.dart';

import '../../../components/exercise_card/exercise_card.dart';
import 'package:lima/app/router.gr.dart' as routes;

class Romana1View extends StatefulWidget {
  Romana1View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Romana1ViewState();
}

class Romana1ViewState extends State<Romana1View> {
  Romana1ViewState({Key? key});

  bool b_card1 = false;
  bool b_card2 = false;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double cardWidth = constraints.maxWidth / 3.2 + 20;
      double cardHeight = constraints.maxHeight / 2.5 + 20;
      return AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    route: '/level1/litere',
                    barColor: Colors.pink[300]!,
                  label: 'Recunoaşterea Literelor',
                  icon: LineIcon.pen().icon!,
                  onStart: () {}
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
                      route: '/level1/litere',
                      barColor: Colors.pink[300]!,
                      label: 'Recunoaşterea Literelor',
                      icon: LineIcon.pen().icon!,
                      onStart: () {
                        setState(() {
                          opacity = 0;
                        });
                        context.router.replace(
                          routes.ExercitiuLitere(level: 1)
                        );
                        l<HeaderManager>().addCrumb("litere");
                      },
                      onHelp: showLitereModal),
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
                    route: '/level1/vocale',
                    barColor: Colors.pink[300]!,
                    label: 'Vocale şi Consoane',
                    icon: LineIcon.book().icon!,
                    onStart: () {}
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
                      route: '/level1/vocale',
                      barColor: Colors.pink[300]!,
                      label: 'Vocale şi Consoane',
                      icon: LineIcon.book().icon!,
                      onStart: () {
                        setState(() {
                          opacity = 0;
                        });
                        context.router.replace(
                            routes.ExercitiuVocale(level: 1));
                        l<HeaderManager>().addCrumb('vocale');
                      },
                      onHelp: showVocaleModal),
                ),
              ),
            ),
          ],
        )
      );
    });
  }
}

void showLitereModal(BuildContext context,
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
void showVocaleModal(BuildContext context,
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
