/// Flutter
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconly/iconly.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';
import 'package:lima/views/components/custom_icon_button/custom_icon_button.dart';
import 'package:lima/views/components/sidemenu/sidemenu_item.dart';
import 'package:lima/views/components/sidemenu/sidemenu_view.dart';
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';

/// Widgets
import 'package:flutter_switch/flutter_switch.dart';
import 'package:keyboard_event/keyboard_event.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lima/models/classes/storage_manager.dart';
/// The viewmodel of this view
import './level1_viewmodel.dart';

/// Storage dependencies

class Level1View extends StatefulWidget {

  @override
  State<Level1View> createState() => _Level1ViewState();
}

class _Level1ViewState extends State<Level1View> {
  String fact = FunFacts.facts[
  Random().nextInt(FunFacts.facts.length)
  ].text ?? '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => Level1ViewModel(),
        builder: (context, model, child) {
          return Container(
            child: Scaffold(
                backgroundColor: const Color(0xFF2A2B2A),
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
                        colorScheme: ItemColor.purple,
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
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFFEFEFE),
                                    width: 1.0,
                                  )
                                )),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: CustomIconButton(
                                      onPressed: () {
                                        if (l<SideMenuManager>().navHistory.isNotEmpty) {
                                          l<SideMenuManager>().pop();
                                        }
                                        Navigator.pop(context);
                                      },
                                      icon: Iconsax.arrow_left_1,
                                      duration: const Duration(milliseconds: 150),
                                      background: const Color(0xFFffffff),
                                      backgroundEnd: const Color(0xFFffffff),
                                      size: 35,
                                      sizeEnd: 45,
                                    )
                                  ),
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: CustomIconButton(
                                        onPressed: () {
                                          l<SideMenuManager>().clearChoice();
                                          context.router
                                              .replace(HomeView(initialIndex: 1));
                                        },
                                        icon: IconlyLight.home,
                                        duration: const Duration(milliseconds: 150),
                                        background: const Color(0xFFffffff),
                                        backgroundEnd: const Color(0xFFffffff),
                                        size: 35,
                                        sizeEnd: 45,
                                      )
                                  ),
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
                                        width: 28,
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
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 100,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(top: 75),
                                          child: Text("ÎNVĂŢĂCEL", style: Theme.of(context).textTheme.headline3!
                                              .copyWith(
                                              color: const Color(0xFFfefefe),
                                              fontFamily: "Dosis",
                                              fontSize: 0.0694 * MediaQuery.of(context).size.height,
                                              fontWeight: FontWeight.w500,
                                          )
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Text("Mate Total: ${ProgressStorage.levels[0].matematica.parts["aritmetica"]}"),
                                        Text("\t-Operatii: ${ProgressStorage.levels[0].matematica.parts["aritmetica"]!.parts["operatii"]}"),
                                        Text("\t-Fractii: ${ProgressStorage.levels[0].matematica.parts["aritmetica"]!.parts["fractii"]}"),
                                        Text("\t-Siruri: ${ProgressStorage.levels[0].matematica.parts["aritmetica"]!.parts["siruri"]}"),
                                        Text("\t-Formare: ${ProgressStorage.levels[0].matematica.parts["aritmetica"]!.parts["formare"]}"),
                                        const Expanded(child: SizedBox()),
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 75),
                                          height: MediaQuery.of(context).size.height / 5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("STIATI CA",
                                                        style: Theme.of(context).textTheme.headline6!
                                                          .copyWith(
                                                            fontFamily: "Dosis",
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 0.02 * MediaQuery.of(context).size.width,
                                                            color: const Color(0xFFacacac)
                                                        )
                                                      ),
                                                      Text(fact,
                                                        style: Theme.of(context).textTheme.headline6!
                                                            .copyWith(
                                                            fontSize: 0.013 * MediaQuery.of(context).size.width,
                                                            color: const Color(0xFFacacac)
                                                      )),
                                                    ]
                                                  ),
                                                )
                                              ),
                                              const SizedBox(width: 150),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: CustomIconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        fact = FunFacts.facts[
                                                        Random().nextInt(FunFacts.facts.length)
                                                        ].text ?? '';
                                                      });
                                                    },
                                                    icon: Iconsax.refresh,
                                                    duration: const Duration(milliseconds: 200),
                                                    size: 0.039 * MediaQuery.of(context).size.width,
                                                    sizeEnd: 0.047 * MediaQuery.of(context).size.width,
                                                    stroke: IconBorder(
                                                      width: 0.003 * MediaQuery.of(context).size.width,
                                                      color: const Color(0xFFfefefe)
                                                    ),
                                                    strokeEnd: IconBorder(
                                                      width: 0.004 * MediaQuery.of(context).size.width,
                                                      color: const Color(0xFFfefefe)
                                                    ),
                                                    rotate: true,
                                                    background: null,
                                                    backgroundEnd: null,
                                                    gradient: const LinearGradient(
                                                      colors:[
                                                        Color(0xFFff1d25),
                                                        Color(0xFF6049b0),
                                                        Color(0xFF0082e6)
                                                      ]
                                                    ),
                                                ),
                                              )
                                            ]
                                          ),
                                        ),
                                      ]
                                    ),
                                  );
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
