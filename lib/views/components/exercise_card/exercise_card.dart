import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math';

class ExerciseCard extends StatefulWidget {
  ExerciseCard(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onStart,
      required this.onHelp,
  });

  /// The label of the Exercise Card
  String label;

  /// The icon of the Exercise Card
  IconData icon;

  /// Function called when the Start button is clicked
  VoidCallback onStart;

  /// Function called when the Help button is clicked
  VoidCallback onHelp;

  @override
  State<StatefulWidget> createState() => ExerciseCardState(
      label: label,
      icon: icon,
      onStart: onStart,
      onHelp: onHelp);
}

class ExerciseCardState extends State<ExerciseCard> {
  ExerciseCardState(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onStart,
      required this.onHelp,
      });

  String label;
  IconData icon;
  VoidCallback onStart, onHelp;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var raport = constraints.maxWidth / 600;
        return AnimatedContainer(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF5F5F5),
                    ]),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    Transform.rotate(
                      angle: icon == Iconsax.arrow_3 ? pi / 4 : 0,
                      child: Icon(icon, color: const Color(0xFF2A2B2A), 
                        size: 60 * raport
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight / 20),
                    Text(label,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: const Color(0xFF2A2B2A),
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                              fontSize: constraints.maxWidth / 20
                            )),
                  ])),
                  const Divider(height: 2, thickness: 1, color: Color(0xFF2A2B2A)),
                  Container(
                    height: constraints.maxHeight / 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max, 
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: 
                      [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: MouseRegion(
                              child: GestureDetector(
                                  child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.ease,
                                      child: Text('Începe', 
                                        style: Theme.of(context).textTheme.headline6!.copyWith(
                                          color: const Color(0xFF2A2B2A), 
                                          fontFamily: 'Manrope', 
                                          fontWeight: FontWeight.w400, 
                                          fontSize: constraints.maxWidth / 22
                                        )
                                      )))),
                        ),
                      ),
                      const VerticalDivider(
                          width: 2, thickness: 1, color: Color(0xFF2A2B2A)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: MouseRegion(
                              child: GestureDetector(
                                  child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.ease,
                                      child: Text('Ajutor', 
                                      style: Theme.of(context).textTheme.headline6!.copyWith(
                                          color: const Color(0xFF2A2B2A), 
                                          fontFamily: 'Manrope', 
                                          fontWeight: FontWeight.w400, 
                                          fontSize: constraints.maxWidth / 25)
                                      )))),
                        ),
                      )
                    ]),
                  )
                ]));
      }
    );
  }
}
