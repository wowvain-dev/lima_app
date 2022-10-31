import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ModalViewModel extends BaseViewModel {
  /// ModalButton decoration
  Color? yesButtonBG, 
         noButtonBG; 

  /// Function triggered when the mouse enters the `yes` button region
  /// inside the Modal Dialog
  void yesOnEnter(PointerEnterEvent event) {
    yesButtonBG = Colors.blue;
    notifyListeners();
  }

  /// Function triggered when the mouse exits the `yes` button region
  /// inside the Modal Dialog
  void yesOnExit(PointerExitEvent event) {
    yesButtonBG = null;
    notifyListeners();
  }

  /// Function triggered when the mouse enters the `no` button region
  /// inside the Modal Dialog
  void noOnEnter(PointerEnterEvent event) {
    noButtonBG = Colors.amber[900]!;
    notifyListeners();
  }

  /// Function triggered when the mouse exits the `no` button region
  /// inside the Modal Dialog
  void noOnExit(PointerExitEvent event) {
    noButtonBG = null; 
    notifyListeners();
  }

}