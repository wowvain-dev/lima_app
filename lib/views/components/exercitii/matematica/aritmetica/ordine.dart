import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';
import 'package:reorderables/reorderables.dart';

class OrdiniSiruri extends StatefulWidget {
  OrdiniSiruri({Key? key});

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

  // void _update(old, ew) {
  //   setState(() {
  //     var el = array[old];
  //     array.removeAt(old);
  //     array.insert(ew, el);
  //   });
  // }

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
                  angle: selectedOrder == Order.ascending ? pi/4 : 5*pi/4,
                  child: const Icon(Iconsax.arrow_up_3, size: 48)
              ),
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
              children: [
                for (var i = 0; i < array.length; i++)
                  AnimatedContainer(
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                    decoration: BoxDecoration(
                      gradient: gradients[i],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "${array[i]}",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: size.width / 50,
                          color: const Color(0xFF2a2b2a)),
                    )),
                  )
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          MouseRegion(
            onEnter: (_) {
              setState(() {
                buttonBG = const LinearGradient(
                    colors: [Color(0xFF576182), Color(0xFF1FC5A8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight);
              });
            },
            onExit: (_) {
              setState(() {
                buttonBG = const LinearGradient(
                    colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight);
              });
            },
            child: GestureDetector(
              onTap: _verify,
              child: AnimatedContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          .copyWith(fontSize: size.width / 60))),
            ),
          ),
          const SizedBox(height: 12),
          MouseRegion(
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
              child: GestureDetector(
                onTap: () {
                  context.router.push(ExerciseWrapper(
                      exercise: OrdiniSiruri(), modal: showOrdiniModal));
                },
                child: Text("Treceţi Peste",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: skip)),
              )),
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

  void _verify() {
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
      print('BRAVO');
      Navigator.pop(context);
      context.router.replace(
          ExerciseWrapper(exercise: OrdiniSiruri(), modal: showOperatiiModal));
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
          ExerciseWrapper(exercise: OrdiniSiruri(), modal: showOperatiiModal));
    }
  }
}
