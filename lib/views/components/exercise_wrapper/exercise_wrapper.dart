import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class ExerciseWrapper extends StatefulWidget {
  ExerciseWrapper({
    Key? key,
    required this.exercise,
    required this.modal,
  });

  /// The exercise inside the wrapper.
  Widget exercise;

  /// The modal function to show when in need of help.
  void Function(BuildContext, void Function()) modal;

  @override
  State<StatefulWidget> createState() => _ExerciseWrapperState(
        exercise: exercise,
        modal: modal,
      );
}

class _ExerciseWrapperState extends State<ExerciseWrapper> {
  _ExerciseWrapperState({
    Key? key,
    required this.exercise,
    required this.modal,
  });

  /// The exercise inside the wrapper.
  Widget exercise;

  /// The modal function to show when in need of help.
  void Function(BuildContext, void Function()) modal;

  Color? settingsColor;
  initState() {
    settingsColor = const Color(0xFFaaaaaa);
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          margin: EdgeInsets.only(
            bottom: constraints.maxHeight / 25,
          ),
          child: Column(children: [
            SizedBox(
                height: constraints.maxHeight / 30 + constraints.maxHeight / 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        settingsColor = const Color(0xFFFEFEFE);
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        settingsColor = const Color(0xFFAAAAAA);
                      });
                    },
                    child: GestureDetector(
                        onTap: () {
                          showDifficultySettingsModal(context);
                        },
                        child: AnimatedContainer(
                    margin: const EdgeInsets.only(right: 24, top: 10),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    child: Icon(
                      Iconsax.setting_2, 
                      color: settingsColor,
                      size: 48,
                    )
                  )
                ),
               ),
              )
            ),
            Expanded(child: Container(child: exercise)),
          ]));
    });
  }
}

void showTryAgainModal(BuildContext context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(Duration.zero, () {
        }).whenComplete(() => Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context)));
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
              colors: [Color(0xFFffc3a0), Color(0xFFffafbd)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                  colors: [
                    Color(0xFF29323c),
                    Color(0xFF485563),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.heart, size: 40), 
                    SizedBox(height: 20),
                    Text("Ai fost aproape! Încearcă iar!",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: MediaQuery.of(context).size.width / 50,
                            )),
                  ],
                )),
          ),
        );
      });
}

void showDifficultySettingsModal(BuildContext context) async {
  showDialog(
    barrierDismissible: false, 
    context: context, 
    builder: (context) {
      var modalWidth = MediaQuery.of(context).size.width - 804;
      print(modalWidth);

      return Dialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), 
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          width:  modalWidth > 650 ? modalWidth : 650,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const SizedBox(width: 10),
                const Icon(
                    IconlyLight.close_square, 
                    color: Color(0x00FEFEFE),
                    size: 36,
                ),
                const Expanded(child: SizedBox()),
                Center(
                  child: Text("Configurare Dificultate", 
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: const Color(0xFFFEFEFE),
                      fontSize:  MediaQuery.of(context).size.width / 40
                    ), 
                  ),
                ), 
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    IconlyLight.close_square, 
                    color: Color(0xFFFEFEFE),
                    size: 36,
                  ),
                ),
                const SizedBox(width: 10),
                ]
              ), 
              const SizedBox(height: 24),
              Column(
                
                children: [
              Row(children: [
                Text("Valoarea minimă a numerelor: ", 
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width / 50
                  )
                ),
                const Expanded(child: SizedBox()),
              ],),
              Row(children: [
                Text("Valoarea maximă a numerelor: ", 
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width / 50
                  )
                ),
                const Expanded(child: SizedBox()),
              ],),
              Row(children: [
                Text("Adâncimea maximă (nr. maxim de paranteze unele în altele): ", 
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width / 50
                  )
                ),
                const Expanded(child: SizedBox()),
              ],),

              ],)
            ]
          )
        )
      );
    }
  );
}