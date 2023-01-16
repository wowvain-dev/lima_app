import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lima/models/classes/header_manager.dart';

import '../../../app/locator.dart';

class BreadcrumbElement extends StatefulWidget {
  BreadcrumbElement({
    Key? key,
    required this.label,
    required this.route,
    this.active = true
  });

  String label;
  PageRouteInfo<dynamic> route;
  bool active;

  @override
  State<BreadcrumbElement> createState() => _BreadcrumbElementState();

  BreadcrumbElement copyWith({String? label, bool? active, PageRouteInfo<dynamic>? route}) =>
      BreadcrumbElement(
        label: label ?? this.label,
        route: route ?? this.route,
        active: active ?? this.active);
}

class _BreadcrumbElementState extends State<BreadcrumbElement> with
  TickerProviderStateMixin {

  AnimationController? hoverController;
  AnimationController? clickController;

  Animation<Color?>? hoverAnimation;
  Animation<double?>? sizeAnimation;


  @override
  void initState() {
    hoverController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 200));
    clickController = AnimationController(vsync:this,
        duration: const Duration(milliseconds: 100));
    hoverController!.addListener(() => setState((){}));
    clickController!.addListener(() => setState((){}));

    hoverAnimation = ColorTween(
      begin: const Color(0x00000000),
      end: const Color(0x66aaaaaa),
    ).chain(CurveTween(curve: Curves.ease)).animate(hoverController!);

    sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).chain(CurveTween(curve: Curves.ease)).animate(clickController!);

    super.initState();
  }

  @override
  void dispose() {
    clickController!.dispose();
    hoverController!.dispose();
    super.dispose();
  }

  @override
  String toString({DiagnosticLevel? minLevel}) => widget.label;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.active == true ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.active == false) return;
        hoverController!.forward();
      },
      onExit: (_) {
        if (widget.active == false) return;
        hoverController!.reverse();
      },
      child: GestureDetector(
        onTap: () {
          if (widget.active == false) return;
          clickController!.forward().whenComplete(
              () => clickController!.reverse()
          );
          hoverController!.reverse();
          l<HeaderManager>().removeUntil(widget.route.path);
          context.router.replace(widget.route);
          print(l<HeaderManager>().routes);
        },
        child: Transform.scale(
          scale: sizeAnimation!.value,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: hoverAnimation!.value
            ),
            child: Text(widget.label, style: Theme.of(context).textTheme.headline6!.
              copyWith(
              fontFamily: 'CartographCF',
              fontWeight: FontWeight.w100,
              fontSize: 20
            )
            )
          ),
        ),
      ),
    );
  }
}