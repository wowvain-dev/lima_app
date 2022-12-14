import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lima/app/locator.dart';
import 'package:stacked/stacked.dart';

/// The dimensions used to manipulate / generate the buttons
class ButtonDimensions {
  ButtonDimensions({
    this.containerSize, 
    this.fontSize, 
    this.iconSize
  });

  /// The sizes of the button container
  Size? containerSize;

  /// The size of the label font
  double? fontSize;

  /// The size of the icon
  double? iconSize;
}

/// The `ViewModel` for the `Home` screen.
class HomeViewModel extends BaseViewModel {
  HomeViewModel({required this.pageIndex}) {
    pageController = PageController(initialPage: pageIndex);

    switch (pageIndex) {
      case 0:
        canGoLeft = false;
        canGoRight = true;
        break;
      case 1:
        canGoLeft = true;
        canGoRight = false;
        break;
    }
  }

  /// The page controller.
  PageController pageController = PageController(initialPage: 0);

  /// The current page index.
  int pageIndex = 0;

  /// Is the current language english?
  bool isEnglish = false,

      /// Can the pageviewer scroll to right
      canGoRight = true,

      /// Can the pageviewer scroll to left
      canGoLeft = false;

  /// Boolean value to check whether the mouse is currently over a button or not.
  bool isMouseOverButton = false;

  /// The size of the view
  Size size = const Size(0, 0);

  /// The sizes of each difficulty button
  List<ButtonDimensions> buttonSizes = List.filled(3, 
    ButtonDimensions(
      containerSize: const Size(0, 0),
      fontSize: 0,
      iconSize: 0,
    )
  );

  /// The focus node that contains the whole screen, used for physical key press events.
  FocusNode focusNode = FocusNode();

  /// Function used to re-enable the left and right buttons (after temporarily disabling them)
  void scroll() async {
    if (pageIndex < 2) canGoRight = true;
    if (pageIndex > 0) canGoLeft = true;
    notifyListeners();
  }
}
