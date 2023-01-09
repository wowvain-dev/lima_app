import 'dart:convert';
import 'dart:io';

import 'package:stack/stack.dart';
import 'package:lima/models/letter.dart';

enum Type {
  letter,
  statement,
  fact,
  word,
  sentence
}

class Letters {
  static List<Letter> letters = List.empty(growable: true);

  Letters._();

  Letters.initialize() {
    const JsonDecoder decoder = JsonDecoder();
    var jsonString = File(".\\assets\\json\\litere.json")
      .readAsStringSync();
    final Map<String, dynamic> jsonMap = decoder.convert(jsonString);

    var value = jsonMap["letters"];
    if (value != null) {
      value.forEach((item) => letters.add(
        Letter(character: item["letter"], audioPath: item["recording"])
      ));
    }
  }
}

class StorageManager {
  StorageManager() {
    Letters.initialize();
  }
}