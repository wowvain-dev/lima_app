import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/classes/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/components/help_section/help_section.dart';
import 'package:lima/views/components/skip_button/skip_button.dart';
import 'package:lima/views/components/verif_button/verif_button.dart';
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:reorderables/reorderables.dart';
import 'package:toast/toast.dart';

import '../../../../../models/classes/storage_manager.dart';

class OrdiniSiruri extends StatefulWidget {
  OrdiniSiruri({Key? key, required this.level});

  int level;

  @override
  // ignore: no_logic_in_create_state
  createState() => _OrdiniSiruriState();
}

class _OrdiniSiruriState extends State<OrdiniSiruri> {
  _OrdiniSiruriState();

  LinearGradient? buttonBG;

  int? start;
  int? end;
  int? length;

  List<int> array = List.empty(growable: true);
  List<Widget> listChildren = List.empty(growable: true);
  List<Gradient> gradients = List.empty(growable: true);
  Order? selectedOrder;

  Color? skip;

  @override
  void initState() {
    print("Started - Array Orders");
    skip = const Color(0xFFaaaaaa);
    var props = l<DifficultyManager>().ordine;
    start = props.lowLimit;
    end = props.maxLimit;
    length = props.length;
    if (end! - start! + 1 < length!) {
      throw Exception(
          "There are less numbers in the ($start, $end) interval than required by $length.");
    }
    if (props.allowedOrders.isEmpty) {
      throw Exception("There are no order types selected.");
    }

    selectedOrder =
        props.allowedOrders[Random().nextInt(props.allowedOrders.length)];

    List<int> tempArray = List.empty(growable: true);
    array = List.generate(length!, (index) {
      var a = Random().nextInt(end! - start!) + start!;
      print("1: $a");

      while (tempArray.contains(a)) {
        a = Random().nextInt(end! - start!) + start!;
      }

      tempArray.add(a);
      return a;
    });

    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    gradients = List.generate(length!, (index) {
      return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF72B2E4), Color(0xFF92E1E2)]);
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var progress = ProgressStorage.levels[widget.level-1].matematica.parts["aritmetica"]!
      .parts["siruri"]!;

    List<Widget> elements = List.empty(growable: true);
    for (int i = 0; i < array.length; i++) {
      elements.add(MouseRegion(
        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
        cursor: SystemMouseCursors.move,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.ease,
          decoration: BoxDecoration(
            gradient: gradients[i],
            borderRadius: BorderRadius.circular(5),
          ),
          width: size.width / 15,
          height: size.width / 15,
          margin: const EdgeInsets.all(10),
          child: Center(
              child: Text(
                "${array[i]}",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: size.width / 40,
                    color: const Color(0xFF2a2b2a)),
              )),
        ),
      ));
    }
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Reordonaţi numerele pentru a le avea aranjate în ordine ${selectedOrder == Order.ascending ? "crescătoare" : "descrescătoare"}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: size.width / 50)),
              // Transform.rotate(
              //   angle: pi/4,
              //   child: const Icon(Iconsax.arrow_up_3)
              // )
            ],
          ),
          const SizedBox(height: 12),
          Transform.rotate(
              angle: selectedOrder == Order.ascending ? pi / 4 : 5 * pi / 4,
              child: const Icon(Iconsax.arrow_up_3, size: 48)),
          const Expanded(child: SizedBox()),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            child: ReorderableRow(
              needsLongPressDraggable: false,
              mainAxisSize: MainAxisSize.max,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  int el = array.removeAt(oldIndex);
                  array.insert(newIndex, el);
                });
              },
              children: elements
              // [
                // for (var i = 0; i < array.length; i++)
                //   MouseRegion(
                //     key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                //     cursor: SystemMouseCursors.move,
                //     child: AnimatedContainer(
                //       duration: const Duration(milliseconds: 250),
                //       curve: Curves.ease,
                //       decoration: BoxDecoration(
                //         gradient: gradients[i],
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       width: 100,
                //       height: 100,
                //       margin: const EdgeInsets.all(10),
                //       child: Center(
                //           child: Text(
                //         "${array[i]}",
                //         style: Theme.of(context).textTheme.headline6!.copyWith(
                //             fontSize: size.width / 50,
                //             color: const Color(0xFF2a2b2a)),
                //       )),
                //     ),
                //   )
              //
              // ],
            ),
          ),
          const Expanded(child: SizedBox()),
          VerifButton(
              height: size.height / 15,
              width: size.width / 7,
              onPressed: _verify,
              child: Text("VERIFICĂ",
                style: Theme.of(context).textTheme.headline6!
                  .copyWith(
                  fontSize: size.width / 60
                )
              )),
          const SizedBox(height: 12),
          SkipButton(
              modal: showOrdiniModal,
              exercise: OrdiniSiruri(level: widget.level)
          ),
          const Expanded(child: SizedBox()),
          HelpSection(showAnswer: () => setState(() {
            showAnswer(selectedOrder!, elements, array);
          } ), modal: showOrdiniModal,
          )
        ]));
  }

  void _verify() {
    var progress = ProgressStorage.levels[widget.level-1].matematica.parts["aritmetica"]!.parts["siruri"]!;
    setState(() {
      Future.delayed(Duration.zero, () {
        buttonBG = const LinearGradient(
            colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight);
      }).whenComplete(() {
        Future.delayed(const Duration(milliseconds: 200), () {
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

    if (selectedOrder == Order.ascending) {
      List<int> _temp = [...array];
      _temp.sort();
      print("$array \n $_temp");
      for (int i = 0; i < array.length; i++) {
        if (_temp[i] != array[i]) {
          showTryAgainModal(context);
          return;
        }
      }
      if (progress.current < progress.total) {
        progress.current += 1;
        print("${progress.current}/${progress.total}");
      } else {
        if (progress.current > progress.total) {
          Navigator.pop(context);
          context.router.replace(ExerciseWrapper(
              exercise: OrdiniSiruri(level: widget.level),
              modal: showOperatiiModal));
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
      print('BRAVO');
      Navigator.pop(context);
      context.router.replace(
          ExerciseWrapper(exercise: OrdiniSiruri(level: widget.level), modal: showOperatiiModal));
    }

    if (selectedOrder == Order.descending) {
      List<int> _temp = [...array];
      _temp.sort((a, b) => b.compareTo(a));
      print("$array \n $_temp");
      for (int i = 0; i < array.length; i++) {
        if (_temp[i] != array[i]) {
          showTryAgainModal(context);
          return;
        }
      }

      print('BRAVO');
      Navigator.pop(context);
      context.router.replace(
          ExerciseWrapper(exercise: OrdiniSiruri(level: widget.level), modal: showOperatiiModal));
    }
  }

  void showAnswer(Order order, List<Widget> widgets, List<int> mappingList) {
    var length = widgets.length;
    bool ordered = false;

    while (!ordered) {
      ordered = true;
      for (int i = 0; i < length - 1; i++) {
        if (order == Order.ascending && mappingList[i] > mappingList[i+1]) {
          var auxW = widgets[i];
          var auxI = mappingList[i];
          widgets[i] = widgets[i+1];
          widgets[i+1] = auxW;
          mappingList[i] = mappingList[i+1];
          mappingList[i+1] = auxI;
          ordered = false;
        } else if (order == Order.descending && mappingList[i] < mappingList[i+1]) {
          var auxW = widgets[i];
          var auxI = mappingList[i];
          widgets[i] = widgets[i+1];
          widgets[i+1] = auxW;
          mappingList[i] = mappingList[i+1];
          mappingList[i+1] = auxI;
          ordered = false;
        }
      }
    }
  }
}
