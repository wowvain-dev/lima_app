/// Flutter
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/views/components/exercise_card/exercise_card.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double cardWidth = constraints.maxWidth / 3.5 + 20;
      double cardHeight = constraints.maxHeight / 4 + 20;
      return Container(
          color: const Color(0xFF2A2B2A),
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
                                    onHelp: () =>
                                        print('adunare si scadere - help')),
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
                                      onStart: () =>
                                          print('adunare si scadere - start'),
                                      onHelp: () =>
                                          print('adunare si scadere - help')),
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
                                    onStart: () => print('fractii - start'),
                                    onHelp: () => print('fractii - help')),
                              )
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
                                      // Transform.rotate(
                                      //   angle: icon == Iconsax.arrow_3 ? pi / 4 : 0,
                                      //   child: Icon(icon, color: const Color(0xFF2A2B2A),
                                      //     size: 60 * raport
                                      //   ),
                                      // ),
                                      onStart: () => print('fractii - start'),
                                      onHelp: () => print('fractii - help')),
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
                                    icon: LineIcons.divide,
                                    onStart: () => print('ordine - start'),
                                    onHelp: () => print('ordine - help')),
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
                                      icon: LineIcons.divide,
                                      onStart: () => print('ordine - start'),
                                      onHelp: () => print('ordine - help')),
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
                                    icon: LineIcons.divide,
                                    onStart: () =>
                                        print('formarea numerelor - start'),
                                    onHelp: () =>
                                        print('formarea numerelor - help')),
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
                                      icon: LineIcons.divide,
                                      onStart: () =>
                                          print('formarea numerelor - start'),
                                      onHelp: () =>
                                          print('formarea numerelor - help')),
                                ),
                              ),
                      ),
                    ])
              ]));
    });
  }
}
