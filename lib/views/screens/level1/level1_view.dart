/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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
          return Scaffold(
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
                        l<SideMenuManager>().currentSubject = Subject.geometrie;
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
                return Row(children: [
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
                                        color: const Color(0xFFF5F5F5))
                                    : const SizedBox())),
                      )),
                  Expanded(
                    child: AutoRouter(
                      placeholder: (context) {
                        return Center(
                          child: Text('Placeholder')
                        );
                      }
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                        onTap: () {
                          l<SideMenuManager>().clearChoice();
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
