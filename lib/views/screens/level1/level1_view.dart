/// Flutter
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconly/iconly.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:lima/models/classes/header_manager.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';
import 'package:lima/views/components/custom_icon_button/custom_icon_button.dart';
import 'package:lima/views/components/header_breadcrumbs/breadcrumb_element.dart';
import 'package:lima/views/components/header_breadcrumbs/header_breadcrumbs.dart';
import 'package:lima/views/components/header_progress/header_progress.dart';
import 'package:lima/views/components/progress_bar/progress_bar.dart';
import 'package:lima/views/components/sidemenu/sidemenu_item.dart';
import 'package:lima/views/components/sidemenu/sidemenu_view.dart';
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart' as simple;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    l<HeaderManager>().removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => Level1ViewModel(),
        builder: (context, model, child) {
          // l<HeaderManager>().addListener(() {
          //   model.notifyListeners();
          // });
          var size = MediaQuery.of(context).size;
          var matematica = ProgressStorage.levels[0].matematica;
          var comunicare = ProgressStorage.levels[0].comunicare;
          print(context.router.stack);
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
                        onPress: () {
                          l<SideMenuManager>().currentSubject =
                              Subject.aritmetica;
                          context.router.push(Aritmetica1View());
                          context.router.pop();
                          l<HeaderManager>().removeToRoot();
                          l<HeaderManager>().addCrumb("aritmetica");
                        }),
                    ItemComponents(
                        subject: Subject.geometrie,
                        colorScheme: ItemColor.blue,
                        icon: Iconsax.shapes,
                        text: 'Geometrie',
                        onPress: () {
                          l<SideMenuManager>().currentSubject = Subject.geometrie;
                          context.router.push(Geometrie1View());
                          context.router.pop();
                          l<HeaderManager>().removeToRoot();
                          l<HeaderManager>().addCrumb("geometrie");
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
                          context.router.push(Romana1View());
                          context.router.pop();
                          l<HeaderManager>().removeToRoot();
                          l<HeaderManager>().addCrumb("romana");
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
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  HeaderBreadcrumbs(currentPath:
                                    context.router.current.router.currentPath
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: HeaderProgress(
                                        route: '',
                                        height: 40,
                                        width: size.width/4
                                    ),
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: size.height / 25
                                  ),
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
                                          LayoutBuilder(builder: (context, constraints) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              Row(
                                                children: [
                                                  Text("Matematică",
                                                      textAlign: TextAlign.start,
                                                      style: Theme
                                                  .of(context).textTheme.headline6!.
                                                  copyWith(
                                                    fontSize: size.width / 40,
                                                        fontFamily: 'Dosis'
                                                  )),
                                                  const Expanded(child: SizedBox()),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        child:
                                                        Stack(
                                                            children: [simple.AnimatedProgressBar(
                                                              duration: const Duration(milliseconds: 400),
                                                              curve: Curves.ease,
                                                              value: matematica.parts["aritmetica"]!.percentage,
                                                              height: size.height * 0.07,
                                                              width: constraints.maxWidth / 2.3,
                                                              backgroundColor: const Color(0xFF252525),
                                                              gradient: const LinearGradient(
                                                                  colors: [
                                                                    Color(0xFFff1d25),
                                                                    Color(0xFF6049b0),
                                                                    Color(0xFF0082e6)
                                                                  ]
                                                              ),
                                                            ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                    color: const Color(0xFFfefefe),
                                                                    width: 2
                                                                  )
                                                                ),
                                                                height: size.height * 0.07,
                                                                width: constraints.maxWidth / 2.3,
                                                                child: Center(child:
                                                                  Text(
                                                                      "${matematica.parts["aritmetica"]!.current}/${matematica.parts["aritmetica"]!.total}",
                                                                    style: Theme.of(context).textTheme.headline6!
                                                                      .copyWith(
                                                                      fontSize: 25
                                                                    )
                                                                  )
                                                                ),
                                                              )
                                                            ]
                                                        ),
                                                      ),
                                                      // ProgressBar(
                                                      //   percentage: matematica.parts["aritmetica"]!.percentage,
                                                      //   height: size.height * 0.08,
                                                      //   width: constraints.maxWidth / 2.3,
                                                      //   gradient: const LinearGradient(
                                                      //       colors:[
                                                      //         Color(0xFFff1d25),
                                                      //         Color(0xFF6049b0),
                                                      //         Color(0xFF0082e6)
                                                      //       ]
                                                      //   ),
                                                      //   gradientFull: const LinearGradient(
                                                      //     colors: [
                                                      //       Color(0xFFe5405e),
                                                      //       Color(0xFFffdb3a),
                                                      //       Color(0xFF50d5b7),
                                                      //       Color(0xFF3fffa2)
                                                      //     ], stops: [
                                                      //       0, .33, .66, 1
                                                      //   ]
                                                      //   )
                                                      // ),
                                                      Text("aritmetică", style:
                                                      Theme.of(context).textTheme.headline6!.
                                                      copyWith(
                                                          fontSize: 25,
                                                          fontFamily: 'CartographCF'
                                                      ))
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Stack(
                                                          children: [simple.AnimatedProgressBar(
                                                            duration: const Duration(milliseconds: 400),
                                                            curve: Curves.ease,
                                                            value: matematica.parts["geometrie"]!.percentage,
                                                            height: size.height * 0.07,
                                                            width: constraints.maxWidth / 2.3,
                                                            backgroundColor: const Color(0xFF252525),
                                                            gradient: const LinearGradient(
                                                                colors: [
                                                                  Color(0xFFff1d25),
                                                                  Color(0xFF6049b0),
                                                                  Color(0xFF0082e6)
                                                                ]
                                                            ),
                                                          ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                      color: const Color(0xFFfefefe),
                                                                      width: 2
                                                                  )
                                                              ),
                                                              height: size.height * 0.07,
                                                              width: constraints.maxWidth / 2.3,
                                                              child: Center(child:
                                                              Text(
                                                                  "${matematica.parts["aritmetica"]!.current}/${matematica.parts["geometrie"]!.total}",
                                                                  style: Theme.of(context).textTheme.headline6!
                                                                      .copyWith(
                                                                      fontSize: 25
                                                                  )
                                                              )
                                                              ),
                                                            )
                                                          ]
                                                      ),
                                                      Text("geometrie", style:
                                                        Theme.of(context).textTheme.headline6!.
                                                          copyWith(
                                                          fontSize: 25,
                                                            fontFamily: 'CartographCF'
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 50),
                                              Row(
                                                children: [
                                                  Text("Limbă şi Comunicare",
                                                      textAlign: TextAlign.start,
                                                      style: Theme
                                                          .of(context).textTheme.headline6!.
                                                      copyWith(
                                                        fontSize: size.width / 40,
                                                          fontFamily: 'Dosis'
                                                      )),
                                                  const Expanded(child: SizedBox()),
                                                ]
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Stack(
                                                          children: [simple.AnimatedProgressBar(
                                                            duration: const Duration(milliseconds: 400),
                                                            curve: Curves.ease,
                                                            value: comunicare.parts["romana"]!.percentage,
                                                            height: size.height * 0.07,
                                                            width: constraints.maxWidth,
                                                            backgroundColor: const Color(0xFF252525),
                                                            gradient: const LinearGradient(
                                                                colors: [
                                                                  Color(0xFFff1d25),
                                                                  Color(0xFF6049b0),
                                                                  Color(0xFF0082e6)
                                                                ]
                                                            ),
                                                          ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  border: Border.all(
                                                                      color: const Color(0xFFfefefe),
                                                                      width: 2
                                                                  )
                                                              ),
                                                              height: size.height * 0.07,
                                                              width: constraints.maxWidth,
                                                              child: Center(child:
                                                              Text(
                                                                  "${comunicare.parts["romana"]!.current}/${comunicare.parts["romana"]!.total}",
                                                                  style: Theme.of(context).textTheme.headline6!
                                                                      .copyWith(
                                                                      fontSize: 25
                                                                  )
                                                              )
                                                              ),
                                                            )
                                                          ]
                                                      ),
                                                      Text("română", style:
                                                      Theme.of(context).textTheme.headline6!.
                                                      copyWith(
                                                          fontSize: 25,
                                                          fontFamily: 'CartographCF'
                                                      ))
                                                    ],
                                                  ),

                                                ]
                                              )
                                            ]
                                          )),
                                          Container(),
                                          const Expanded(child: SizedBox()),
                                          Container(
                                            padding: const EdgeInsets.only(bottom: 50),
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
                                                      size: 0.045 * MediaQuery.of(context).size.width,
                                                      sizeEnd: 0.05 * MediaQuery.of(context).size.width,
                                                      stroke: IconBorder(
                                                        width: 0.002 * MediaQuery.of(context).size.width,
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
