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
                  math: [
                    Text("Aritmetică",
                      style: Theme.of(context).textTheme.headline6! 
                        .copyWith(
                          fontSize: 20,
                          color: const Color(0xff2a2b2a)
                        )
                    ),
                    Text("Geometrie", 
                      style: Theme.of(context).textTheme.headline6! 
                        .copyWith(
                          fontSize: 20,
                          color: const Color(0xff2a2b2a)
                        )
                    )
                  ], 
                  lang: [
                    Text("Limba română", 
                      style: Theme.of(context).textTheme.headline6! 
                        .copyWith(
                          fontSize: 20,
                          color: const Color(0xff2a2b2a)
                        )
                    ), 
                  ],
                  title: 'Culegerea învăţăcelului',
                  width: MediaQuery.of(context).size.width / 4,
              ),
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
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                                model.notifyListeners();
                              },
                              child: 
                              
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 16,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: !model.isOpened 
                            ? SvgPicture.asset(
                              'assets/svg/double-arrow-right.svg',
                              color: const Color(0xFFF5F5F5))
                            : SizedBox()
                              )),
                              
                              // Container(
                              //   margin: const EdgeInsets.only(left: 12),
                              //   child: 
                              //     model.isOpened 
                              //       ? SizedBox(width: 8) 
                              //       : SvgPicture.asset(
                              //     'assets/svg/double-arrow-right.svg',
                              //     color: const Color(0xFFF5F5F5)
                              //   ),
                              // )),
                        )),
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
