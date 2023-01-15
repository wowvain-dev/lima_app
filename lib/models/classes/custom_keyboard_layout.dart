import 'package:virtual_keyboard_flutter/virtual_keyboard_flutter.dart';

class VirtualKeyboardRomanianLayoutKeys extends VirtualKeyboardLayoutKeys {
  List<VirtualKeyboardDefaultLayouts> defaultLayouts = [];
  VirtualKeyboardRomanianLayoutKeys();

  int getLanguagesCount() => defaultLayouts.length;

  List<List> getLanguage(int index) {
    return _customRomanianLayout;
  }
}

/// Keys for Virtual Keyboard's rows.
const List<List> _customRomanianLayout = [
  // Row 2
  [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
    VirtualKeyboardKeyAction.Backspace
  ],
  // Row 3
  [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    ';',
    '\'',
    VirtualKeyboardKeyAction.Return
  ],
  // Row 4
  [
    VirtualKeyboardKeyAction.Shift,
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
    ',',
    '.',
    '/',
    VirtualKeyboardKeyAction.Shift
  ],
  // Row 5
  [
    'ă',
    'î',
    VirtualKeyboardKeyAction.Space,
    'â',
    'ţ',
    'ş'
  ]
];
