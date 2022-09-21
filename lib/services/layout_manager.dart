/// Flutter Widgets
import 'package:flutter/widgets.dart';

enum Layout { vertical, horizontal }

class LayoutManager {
  Layout _currentLayout = Layout.vertical;

  set layout(Layout newLayout) {
    _currentLayout = newLayout;
  }

  Layout get layout {
    return _currentLayout;
  }

  void updateLayout(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (size.width <= size.height) {
      layout = Layout.vertical;
    } else {
      layout = Layout.horizontal;
    }
  }
}
