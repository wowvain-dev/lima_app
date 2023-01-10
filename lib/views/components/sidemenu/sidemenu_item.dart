import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lima/models/sidemenu_manager.dart';

enum ItemColor {
  lightBlue,
  veryLightBlue,
  electricBlue,
  skyBlue,
  lightGreen,
  grassGreen,
  poisonGreen,
  lightPink,
  darkPurple,
  purple,
  blue,
  orange,
}

class ItemComponents {
  ItemComponents({
    required this.colorScheme,
    required this.icon,
    required this.text,
    required this.onPress,
    required this.subject,
  });
  Subject subject;
  ItemColor colorScheme;
  IconData icon;
  String text;
  VoidCallback onPress;
}

class SideMenuItem extends StatefulWidget {
  SideMenuItem({
    Key? key,
    required this.icon,
    required this.colorScheme,
    required this.text,
    required this.onPress,
    required this.textStyle, 
    required this.subject,
    this.iconSize = 25, 
  });

  IconData icon;
  ItemColor colorScheme;
  String text;
  double iconSize;
  TextStyle textStyle;
  Subject subject;
  VoidCallback onPress;

  @override
  State<SideMenuItem> createState() => _SideMenuItemState(
        icon: icon,
        colorScheme: colorScheme,
        text: text,
        onPress: onPress,
        textStyle: textStyle, 
        iconSize: iconSize, 
        subject: subject
      );
}

class _SideMenuItemState extends State<SideMenuItem> 
  with SingleTickerProviderStateMixin{
  _SideMenuItemState({
    Key? key,
    required this.icon,
    required this.colorScheme,
    required this.text,
    required this.onPress,
    required this.textStyle,
    required this.subject,
    this.iconSize = 25,
  });

  IconData icon;
  ItemColor colorScheme;
  String text;
  TextStyle textStyle;
  double iconSize;
  Subject subject;
  VoidCallback onPress;

  AnimationController? controller;
  Animation<double>? onHoverAnimation;

  Map<String, Color> colors = {
    "background": const Color(0x00FFFFFF),
    "circle": const Color(0x00FFFFFF),
    "text": const Color(0x00FFFFFF),
    "icon": const Color(0x00FFFFFF),
    "hover": const Color(0x00FFFFFF),
  };

  @override
  void initState() {
    /// Initialize animation controller
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 200),
    );
    controller!.addListener(() {setState((){});});
    if (colorScheme == ItemColor.blue) {
      colors["background"] = const Color(0xFFB2D2FA);
      colors["circle"] = const Color(0xFF1672EC);
      colors["text"] = const Color(0xFF0A3977);
      colors["icon"] = const Color(0xFFC5DCFA);
      colors["hover"] = const Color(0xFFE2EEFD);
    }

    if (colorScheme == ItemColor.purple) {
      colors["background"] = const Color(0xFFCB93FF);
      colors["circle"] = const Color(0xFF9A0FBF);
      colors["text"] = const Color(0xFF4D085F);
      colors["icon"] = const Color(0xFFECB9F9);
      colors["hover"] = const Color(0xBBD9B1FF);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var height = MediaQuery.of(context).size.height;
        textStyle = textStyle.copyWith(
          fontSize: constraints.maxWidth / 16
        );
        iconSize = constraints.maxWidth / 16;
        onHoverAnimation = Tween<double>(
          begin: 0, 
          end: constraints.maxWidth
        ).animate(controller!);
        return GestureDetector(
        onTap: () {
          setState(() {
            // if (l<SideMenuManager>().subject != subject) {
            //   l<SideMenuManager>().currentSubject = subject;
            // }
            onPress();
          });
        },
        child: MouseRegion(
          onEnter: (_) {
            controller!.forward();
          },
          onExit: (_) {
            controller!.reverse();
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250), 
                curve: Curves.ease,
                width: onHoverAnimation!.value, 
                height: height / 10,
                  decoration: BoxDecoration(
                      color: colors["hover"],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
              ),
            ), 
            Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                height: height / 10,
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
                  decoration: BoxDecoration(
                      color:
                          l<SideMenuManager>().subject == subject 
                          ? colors["background"] : const Color(0x00000000),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Row(children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors["circle"],
                        ),
                        child: Icon(
                          icon,
                          color: colors["icon"],
                          size: iconSize,
                        )),
                    const SizedBox(width: 12),
                    Text(text,
                        style: textStyle.copyWith(
                            color: colors["text"],
                            fontWeight: FontWeight.w700))
                  ])),
            ),
          ]),
        ),
      );}
    );
  }
}
