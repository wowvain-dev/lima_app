/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:lima/views/components/sidemenu/sidemenu_view.dart';
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';

/// Widgets
import 'package:flutter_switch/flutter_switch.dart';
import 'package:keyboard_event/keyboard_event.dart';

/// The viewmodel of this view
import './level2_viewmodel.dart';

/// Storage dependencies
import 'package:realm/realm.dart';

class Level2View extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => Level2ViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              onDrawerChanged: (isOpened) {
                model.isOpened = isOpened;
                model.notifyListeners();
              },
              drawer: SideMenu(
                  width: MediaQuery.of(context).size.width / 4,
                  math: [SizedBox()], 
                  lang: [SizedBox()],
              ),
              body: Builder(
                builder: (BuildContext context) {
                  return Row(children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.ease,
                        width: model.isOpened
                            ? MediaQuery.of(context).size.width / 4
                            : 0),
                    Column(children: [
                      GestureDetector(
                          onTap: () {
                            context.router.replace(HomeView(initialIndex: 1));
                          },
                          child: const Icon(
                            Icons.arrow_back,
                          )),
                      GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                            model.notifyListeners();
                          },
                          child: const Icon(Icons.arrow_forward_ios))
                    ]),
                  ]);
                }
              ));
        });
  }
}
