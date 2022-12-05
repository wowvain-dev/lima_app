import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart'
    hide ExerciseWrapper;
import 'package:lima/views/screens/level1/materii/aritmetica1_view.dart';

class OrdiniSiruri extends StatefulWidget {
  OrdiniSiruri({Key? key});

  @override
  // ignore: no_logic_in_create_state
  createState() => _OrdiniSiruriState();
}

class _OrdiniSiruriState extends State<OrdiniSiruri> {
  _OrdiniSiruriState();

  var f1_node = FocusNode();
  var f2_node = FocusNode();

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();

  LinearGradient? buttonBG;

  int? start;
  int? end;

  List array = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  void _update(old, ew) {
    setState(() {
      var el = array[old];
      array.removeAt(old);
      array.insert(ew, el);
    });
  }

  @override
  void initState() {
    var props = l<DifficultyManager>().ordine;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250,
            ),
            child: ReorderableListView(
                onReorder: _update,
                scrollDirection: Axis.horizontal,
                children: [
                  for (final item in array)
                    Container(
                      key: ValueKey(item),
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                            ),
                          ]),
                      child: Center(
                        child: Text('Item $item'),
                      ),
                    ),
                ]),
          )
        ]));
  }
}
