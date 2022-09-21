import 'package:flutter/widgets.dart';
import 'package:scoalafun/app/locator.dart';
import 'package:scoalafun/services/layout_manager.dart';
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
}
