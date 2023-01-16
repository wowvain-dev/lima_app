import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';
import 'package:lima/views/components/header_breadcrumbs/breadcrumb_element.dart';
import 'package:tuple/tuple.dart';

import '../../app/locator.dart';
import '../../app/router.gr.dart';
import '../../views/components/custom_icon_button/custom_icon_button.dart';

class HeaderManager extends ChangeNotifier{
  List<Widget> routes = List.empty(growable: true);
  final List<Tuple2<String, BreadcrumbElement>> _path = List.empty(growable: true);
  int level = 1;

  Map<String, BreadcrumbElement> elements = Map.identity();

  HeaderManager.init() {

    elements = <String, BreadcrumbElement>{
      "romana": BreadcrumbElement(label: "Română", route: Romana1View()),
      "aritmetica": BreadcrumbElement(label: "Aritmetică", route: Aritmetica1View()),
      "geometrie": BreadcrumbElement(label: "Geometrie", route: Geometrie1View()),
      "operatii": BreadcrumbElement(label: "Operaţii", route: Operatii(level: level)),
      "fractii": BreadcrumbElement(label: "Fracţii", route: Fractii(level: level)),
      "siruri": BreadcrumbElement(label: "Şiruri", route: Fractii(level: level)),
      "formare": BreadcrumbElement(label: "Formare Numere", route: Formare(level: level)),
      "litere": BreadcrumbElement(label: "Litere", route: ExercitiuLitere(level: level)),
      "vocale": BreadcrumbElement(label: "Vocale & Consoane", route: ExercitiuVocale(level: level))
    };
  }

  void update() {
    notifyListeners();
  }

  void addCrumb(String route) {
    print(route);
    routes.add(
      elements[route]!
    );
    _path.add(
      Tuple2(route, elements[route]!),
    );
    print(_path);
    notifyListeners();
  }

  void removeCrumb(String route) {
    routes.remove(
      elements[route]!
    );
    _path.remove(
      Tuple2(route, elements[route]!)
    );
    notifyListeners();
  }

  void removeToRoot() {
    while (routes.isNotEmpty) {
      routes.removeLast();
    }
    while (_path.isNotEmpty) {
      _path.removeLast();
    }
    notifyListeners();
  }

  int removeUntil(String routeName) {
    if (_path.isEmpty) return 0;
    int cnt = 0;
    for (int i = _path.length-1 ; i >= 0; i--) {
      if (_path[i].item1 == routeName) break;
      cnt++;
    }
    while(cnt-- > 0) {
      routes.removeLast();
      _path.removeLast();
    }
    notifyListeners();
    return cnt;
  }
}