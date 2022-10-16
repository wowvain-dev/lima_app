/// Flutter
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lima/views/components/lined_text/lined_text.dart';

/// Architectural dependencies
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/app/locator.dart';

import '../on_hover_component/on_hover_component.dart';

class SideMenu extends StatefulWidget {
  SideMenu({
    this.title,
    required this.width,
    required this.math,
    required this.lang,
  });

  /// The width of the menu
  double? width;

  /// The title of the sidemenu
  String? title;

  /// The mathematics chapters
  List<Widget> math;

  /// The language chapters
  List<Widget> lang;

  @override
  State<SideMenu> createState() =>
      _SideMenuState(title: title, width: width, math: math, lang: lang);
}

class _SideMenuState extends State<SideMenu> {
  _SideMenuState({
    this.title,
    required this.width,
    required this.math,
    required this.lang,
  });

  /// The width of the menu
  double? width;

  /// The title of the sidemenu
  String? title;

  /// The mathematics chapters
  List<Widget> math;

  /// The language chapters
  List<Widget> lang;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        width = constraints.maxWidth / 4;
        print(context);
        print(constraints);
        return Drawer(
          width: width,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFFA6E1FA),
                  Color(0xFFB9FFB7),
                ])),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(children: <Widget>[
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(title ?? '',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: width! / 12,
                                    color: const Color(0xFF2A2B2A),
                                  )),
                    ),
                    const Divider(thickness: 2, color: Color(0xFF2A2B2A)),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LinedText('MATEMATICĂ',
                                    leftFlex: 1,
                                    rightFlex: 4,
                                    textAlign: TextAlign.left,
                                    thickness: 1,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: const Color(0xFF2A2B2A),
                                            fontSize: width! / 17),
                                    lineColor: const Color(0xFF2A2B2A)),
                                    SizedBox(height: 12),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var element in math) ...[
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                OnHover(
                                                  child: element
                                                ), 
                                              ]),
                                        ), 
                                        const SizedBox(height: 8),
                                      ],
                                    ])
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LinedText('LIMBĂ ŞI COMUNICARE',
                                    leftFlex: 1,
                                    rightFlex: 4,
                                    textAlign: TextAlign.left,
                                    thickness: 1,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: const Color(0xFF2A2B2A),
                                            fontSize: width! / 17),
                                    lineColor: const Color(0xFF2A2B2A)),
                                    SizedBox(height: 12),
                                for (var element in lang) element,
                              ],
                            ),
                          ),
                        ])),
                    // Expanded(
                    //   child: content ?? const SizedBox()
                    // ),
                    const Divider(thickness: 2, color: Color(0xFF2A2B2A)),
                    Container(
                        padding: EdgeInsets.only(bottom: 8, top: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.settings_outlined,
                                color: Color(0xFF2A2B2A),
                                size: 35,
                              ),
                              Text('Setări',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: const Color(0xFF2A2B2A),
                                          fontSize: width! / 15))
                            ]))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                            'assets/svg/double-arrow-left.svg',
                            color: const Color(0xFF2A2B2A))),
                  )),
            ]),
          ));
    });
  }
}
