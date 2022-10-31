/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:lima/models/sidemenu_manager.dart';
import 'package:lima/views/components/sidemenu/sidemenu_item.dart';
import 'package:lima/views/components/sidemenu/sidemenu_view.dart';
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';

/// Widgets
import 'package:flutter_switch/flutter_switch.dart';
import 'package:keyboard_event/keyboard_event.dart';
import 'package:iconsax/iconsax.dart';

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
          return Container(
            child: Scaffold(
                backgroundColor: Color(0xFF2A2B2A),
                onDrawerChanged: (isOpened) {
                  model.isOpened = isOpened;
                  model.notifyListeners();
                },
                drawer: SideMenu(
                  math: [
                    ItemComponents(
                        subject: Subject.aritmetica,
                        colorScheme: ItemColor.blue,
                        icon: Iconsax.math,
                        text: 'Aritmetică',
                        // toggled: l<SideMenuManager>().subject == Subject.aritmetica,
                        onPress: () {
                          l<SideMenuManager>().currentSubject =
                              Subject.aritmetica;
                          Navigator.pop(context);
                          context.router.pushNamed('/level1/aritmetica');
                        }),
                    ItemComponents(
                        subject: Subject.geometrie,
                        colorScheme: ItemColor.blue,
                        icon: Iconsax.shapes,
                        text: 'Geometrie',
                        onPress: () {
                          l<SideMenuManager>().currentSubject =
                              Subject.geometrie;
                          Navigator.pop(context);
                          context.router.pushNamed('/level1/geometrie');
                        }),
                  ],
                  lang: [
                    ItemComponents(
                        subject: Subject.romana,
                        colorScheme: ItemColor.blue,
                        icon: Iconsax.book_1,
                        text: 'Limba Română',
                        onPress: () {
                          l<SideMenuManager>().currentSubject = Subject.romana;
                          Navigator.pop(context);
                          context.router.pushNamed('/level1/romana');
                        })
                  ],
                  title: 'Culegerea învăţăcelului',
                  width: MediaQuery.of(context).size.width / 4,
                ),
                body: LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Column(
                      //     mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //   Expanded(
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: [
                      //       Expanded(
                      //         child: Align(
                      //             alignment: Alignment.topLeft,
                      //             child: Container(
                      //                 width: 150,
                      //                 height: 150,
                      //                 child: Image.network(
                      //                     "https://i.pinimg.com/originals/46/ae/f8/46aef8ac37957c677eabf4ed78a5fc67.jpg"))),
                      //       ),
                      //       Align(
                      //           alignment: Alignment.topRight,
                      //           child: Container(
                      //               width: 150,
                      //               height: 150,
                      //               child: Image.network(
                      //                   "https://i.pinimg.com/originals/46/ae/f8/46aef8ac37957c677eabf4ed78a5fc67.jpg"))),
                      //     ]),
                      //   ),
                      //   Expanded(
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: [
                      //       Expanded(
                      //         child: Align(
                      //             alignment: Alignment.bottomLeft,
                      //             child: Container(
                      //                 width: 150,
                      //                 height: 150,
                      //                 child: Image.network(
                      //                     "https://i.pinimg.com/originals/46/ae/f8/46aef8ac37957c677eabf4ed78a5fc67.jpg"))),
                      //       ),
                      //       Align(
                      //           alignment: Alignment.bottomRight,
                      //           child: Container(
                      //               width: 150,
                      //               height: 150,
                      //               child: Image.network(
                      //                   "https://i.pinimg.com/originals/46/ae/f8/46aef8ac37957c677eabf4ed78a5fc67.jpg"))),
                      //     ]),
                      //   ),
                      // ]),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (l<SideMenuManager>().navHistory.isNotEmpty) {
                                          l<SideMenuManager>().pop();
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Iconsax.arrow_left_1,
                                        size: 30,
                                      )),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        l<SideMenuManager>().clearChoice();
                                        context.router
                                            .replace(HomeView(initialIndex: 1));
                                      }, 
                                      child: const Icon(
                                        IconlyLight.home, 
                                        size: 30, 
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(children: [
                              AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.ease,
                                  width: model.isOpened
                                      ? MediaQuery.of(context).size.width / 4
                                      : 0),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                      model.notifyListeners();
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        width: 16,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: !model.isOpened
                                                ? SvgPicture.asset(
                                                    'assets/svg/double-arrow-right.svg',
                                                    color:
                                                        const Color(0xFFF5F5F5))
                                                : const SizedBox())),
                                  )),
                              Expanded(
                                child: AutoRouter(placeholder: (context) {
                                  return Center(child: Text('Placeholder'));
                                }),
                              ),
                            ]),
                          ),
                        ],
                      )
                    ],
                  );
                })),
          );
        });
  }
}
