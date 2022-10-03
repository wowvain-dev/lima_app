import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/services/layout_manager.dart';
import 'package:stacked/stacked.dart';

/// The `ViewModel` for the `Home` screen.
class HomeViewModel extends BaseViewModel {
  String textVal = 'vertical';
  void updateText(BuildContext context) {
    l<LayoutManager>().updateLayout(context);
    var temp = textVal;
    textVal = l<LayoutManager>().layout == Layout.vertical
        ? 'vertical'
        : 'horizontal';
    if (temp == textVal) return;
    notifyListeners();
  }

  /// The page controller.
  PageController pageController = PageController(initialPage: 0);

  /// The current page index.
  int pageIndex = 0;

  /// Is the current language english?
  bool isEnglish = false;
}
