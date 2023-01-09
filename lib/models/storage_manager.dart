import 'dart:convert';
import 'dart:developer';
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
    String jsonString = "";

    if (Platform.isWindows) {
      log("Loading `./assets/json/litere.json`", time: DateTime.now(),
        name: "Asset Loading"
      );
      jsonString = File(".\\assets\\json\\litere.json")
          .readAsStringSync();
      log("Loaded `./assets/json/litere.json`", time: DateTime.now(),
          name: "Asset Loading"
      );
    } else if (Platform.isLinux) {
      log("Loading `./assets/json/litere.json`", time: DateTime.now(),
          name: "Asset Loading"
      );
      jsonString = File("./assets/json/litere.json")
          .readAsStringSync();
      log("Loaded `./assets/json/litere.json`", time: DateTime.now(),
          name: "Asset Loading"
      );
    }

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