import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lima/app/router.gr.dart';

import 'package:iconly/iconly.dart';
import 'package:lima/models/classes/header_manager.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';

import '../../../app/locator.dart';
import '../custom_icon_button/custom_icon_button.dart';
import 'breadcrumb_element.dart';

// class _InheritedHeaderState extends InheritedWidget {
//   final HeaderBreadcrumbState data;
//
//   _InheritedHeaderState({
//     Key? key,
//     required this.data,
//     required Widget child
//   }) : super(key: key, child: child);
//
//   @override
//   bool updateShouldNotify(_InheritedHeaderState old) => true;
// }

class HeaderBreadcrumbs extends StatefulWidget {
  HeaderBreadcrumbs({required this.currentPath});

  String currentPath;

  // static HeaderBreadcrumbState of(BuildContext context) {
  //   return (context.getElementForInheritedWidgetOfExactType<_InheritedHeaderState>() as _InheritedHeaderState).data;
  // }

  @override
  State<HeaderBreadcrumbs> createState() => HeaderBreadcrumbState();
}

class HeaderBreadcrumbState extends State<HeaderBreadcrumbs> {
  HeaderBreadcrumbState({Key? key});

  List<Widget> _list = List.empty(growable: true);

  void _managerListener() {
    if (mounted)
      setState(() {});
  }

  @override
  void initState() {
    l<HeaderManager>().addListener(() {
      _managerListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    l<HeaderManager>().removeListener(_managerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentPath = context.router.currentPath;
    _list.clear();
    _list.add(
      Container(
          height: 50,
          width: 50,
          child: CustomIconButton(
            onPressed: () {
              if (currentPath.contains("level1")) {
                context.router.popUntilRouteWithName('level1');
                context.router.push(Level1View());
                l<SideMenuManager>().clearChoice();
              } else if (currentPath.contains("level2")) {
                context.router.popUntilRouteWithName('level2');
                context.router.push(Level2View());
              } else if (currentPath.contains("level3")) {
                context.router.popUntilRouteWithName("level3");
                context.router.push(Level3View());
              }
              l<HeaderManager>().removeToRoot();
            },
            icon: IconlyLight.home,
            duration: const Duration(milliseconds: 150),
            background: const Color(0xFFffffff),
            backgroundEnd: const Color(0xFFffffff),
            size: 25,
            sizeEnd: 35,
          )
      ),
    );

    for (var i = 0; i < l<HeaderManager>().routes.length; i++) {
          _list.addAll([
            Text("/", style: Theme.of(context).textTheme.headline6!.
              copyWith(fontFamily: 'CartographCF', fontWeight: FontWeight.w500)
            ),
            i == l<HeaderManager>().routes.length-1
                ? (l<HeaderManager>().routes[i] as BreadcrumbElement)
                  .copyWith(active: false)
                : l<HeaderManager>().routes[i]
          ]);
        }

    return Row(
        children: _list
    );
}

  void _populateHeader() {
    // setState(() {
    //   routes.clear();
    //   routes.addAll([
    //     Container(
    //         height: 50,
    //         width: 50,
    //         child: CustomIconButton(
    //           onPressed: () {
    //             if (widget.currentPath.contains("level1")) {
    //               context.router.popUntilRouteWithName('level1');
    //               context.router.push(Level1View());
    //               l<SideMenuManager>().clearChoice();
    //             } else if (widget.currentPath.contains("level2")) {
    //               context.router.popUntilRouteWithName('level2');
    //               context.router.push(Level2View());
    //             } else if (widget.currentPath.contains("level2")) {
    //               context.router.popUntilRouteWithName("level3");
    //               context.router.push(Level3View());
    //             }
    //             // print(context.router.current.router.currentPath);
    //           },
    //           icon: IconlyLight.home,
    //           duration: const Duration(milliseconds: 150),
    //           background: const Color(0xFFffffff),
    //           backgroundEnd: const Color(0xFFffffff),
    //           size: 25,
    //           sizeEnd: 35,
    //         )
    //     ),
    //   ]
    //   );
    //   var paths = widget.currentPath.split('/');
    //   paths.removeAt(0);
    //   paths.removeAt(0);
    //   if (paths.contains("aritmetica")) {
    //     routes.addAll([
    //       Text("/",  style: Theme.of(context).textTheme.headline6!.copyWith( fontSize: 25
    //       )),
    //       BreadcrumbElement(label: "Aritmetica", route: Aritmetica1View()),
    //     ]);
    //   }
    //   if (paths.contains("geometrie")) {
    //     routes.addAll([
    //       Text("/",  style: Theme.of(context).textTheme.headline6!.copyWith(
    //           fontSize: 25
    //       )),
    //       BreadcrumbElement(label: "Geometrie", route: Geometrie1View()),
    //     ]);
    //   }
    //   if (paths.contains("romana")) {
    //     routes.addAll([
    //       Text("/",  style: Theme.of(context).textTheme.headline6!.copyWith(
    //           fontSize: 25
    //       )),
    //       BreadcrumbElement(label: "Română", route: Romana1View()),
    //     ]);
    //   }
    //   if (paths.contains("operatii")) {
    //     routes.addAll([
    //       Text("/",  style: Theme.of(context).textTheme.headline6!.copyWith( fontSize: 25
    //       )),
    //       BreadcrumbElement(label: "Aritmetica", route: Aritmetica1View()),
    //     ]);
    //     routes.addAll([
    //       Text("/",  style: Theme.of(context).textTheme.headline6!.copyWith(
    //           fontSize: 25
    //       )),
    //       BreadcrumbElement(label: "Operaţii", route: Operatii(level: 1)),
    //     ]);
    //   }
    //   print(paths);
    //
    // });
  }
}