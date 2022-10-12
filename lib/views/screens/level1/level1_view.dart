/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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
import './level1_viewmodel.dart';

/// Storage dependencies
import 'package:realm/realm.dart';

class Level1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => Level1ViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              onDrawerChanged: (isOpened) {
                model.isOpened = isOpened;
                model.notifyListeners();
              },
              drawer: SideMenu(
                  width: MediaQuery.of(context).size.width / 4,
                  content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 8; i++)
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              child: Text('Element $i',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF2A2B2A))))
                      ])),
              body: Builder(builder: (BuildContext context) {
                return Row(
                    children: [
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.ease,
                          width: model.isOpened
                              ? MediaQuery.of(context).size.width / 4
                              : 0),
                      Expanded(
                        child: Align(
                          child: GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                                model.notifyListeners();
                              },
                              child: SvgPicture.asset(
                                'assets/svg/double-arrow-right.svg',
                                color: const Color(0xFFF5F5F5)
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                            onTap: () {
                              context.router.replace(HomeView(initialIndex: 1));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                            )),
                      ),
                    ]);
              }));
        });
  }
}
