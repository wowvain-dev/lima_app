/// Flutter
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lima/views/components/lined_text/lined_text.dart';
import 'package:lima/views/components/sidemenu/sidemenu_item.dart';

/// Architectural dependencies
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/app/locator.dart';

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
  List<ItemComponents> math;

  /// The language chapters
  List<ItemComponents> lang;

  @override
  State<SideMenu> createState() =>
      _SideMenuState(title: title, width: width, math: math, lang: lang);
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
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
  List<ItemComponents> math;

  /// The language chapters
  List<ItemComponents> lang;

  AnimationController? closeButtonController;
  Animation<double>? closeButtonAnimation;

  @override
  void initState() {
    closeButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));

    closeButtonController!.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _scrollController = ScrollController();

    return LayoutBuilder(builder: (context, constraints) {
      width = constraints.maxWidth / 4;
      closeButtonAnimation = Tween<double>(begin: width! / 12, end: width! / 14)
          .animate(closeButtonController!);
      return Drawer(
          width: width,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFF5F5F5),
                ])),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(children: <Widget>[
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text('Culegerea\nÎnvăţăcelului',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontSize: width! / 14,
                                      color: const Color(0xFF2A2B2A),
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800,
                                    )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // closeButtonController!.forward().whenComplete(() =>
                            //     closeButtonController!.reverse().whenComplete(
                            //         () => Navigator.pop(context)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: width! / 30, 
                              left: width! / 30,
                            ),
                            width: width! / 20,

                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Iconsax.setting_2,
                                  size: width! / 12,
                                  color: const Color(0xFF2A2B2A)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            closeButtonController!.forward().whenComplete(() =>
                                closeButtonController!.reverse().whenComplete(
                                    () => Navigator.pop(context)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: width! / 30, 
                              left: width! / 30,
                            ),
                            width: width! / 20,

                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Iconsax.close_square,
                                  size: closeButtonAnimation!.value,
                                  color: const Color(0xFF2A2B2A)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2, color: Color(0xFFE0E0E0)),
                    Expanded(
                        child: RawScrollbar(
                      thumbColor: const Color(0xFFD0D0D0),
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: constraints.maxHeight / 10),

                              /// TODO(wowvain-dev): FIGURE OUT THE `.maxHeight` BASED
                              /// DIMENSIONS FOR EVERYTHING
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'LIMBĂ ŞI COMUNICARE',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontFamily: 'Manrope',
                                                color: const Color(0xFF818181)),
                                      ),
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight / 50),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var element in lang) ...[
                                            SideMenuItem(
                                              subject: element.subject,
                                              icon: element.icon,
                                              text: element.text,
                                              colorScheme: element.colorScheme,
                                              onPress: () {
                                                setState(() {
                                                  element.onPress;
                                                });
                                              },
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      fontSize: width! / 20),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ])
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              const Divider(
                                  thickness: 2, color: Color(0xFFF0F0F0)),
                              SizedBox(height: 10),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'MATEMATICĂ',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontFamily: 'Manrope',
                                                color: const Color(0xFF818181)),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var element in math) ...[
                                            SideMenuItem(
                                                subject: element.subject,
                                                icon: element.icon,
                                                text: element.text,
                                                colorScheme:
                                                    element.colorScheme,
                                                onPress: () {
                                                  setState(() {
                                                    element.onPress;
                                                  });
                                                },
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      fontSize: width! / 20,
                                                    )),
                                            const SizedBox(height: 8),
                                          ],
                                        ])
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    )),
                    // Expanded(
                    //   child: content ?? const SizedBox()
                    // ),
                    const Divider(thickness: 2, color: Color(0xFFE0E0E0)),
                    Container(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('v 1.0.0',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontFamily: 'Manrope',
                                          color: const Color(0xFFD0D0D0),
                                          fontSize: width! / 25))
                            ]))
                  ],
                ),
              ),
              const SizedBox(width: 24),
            ]),
          ));
    });
  }
}
