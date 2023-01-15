import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:lima/models/classes/progress_manager.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';
import 'package:stack/stack.dart';
import 'package:lima/models/classes/letter.dart';
import 'package:lima/models/classes/storage_manager.dart';

enum Type { letter, statement, fact, word, sentence }

class Letters {
  static List<Letter> letters = List.empty(growable: true);

  Letters._();

  Letters.initialize() {
    const JsonDecoder decoder = JsonDecoder();
    String jsonString = "";

    if (Platform.isWindows) {
      log("Loading `./assets/json/litere.json`",
          time: DateTime.now(), name: "Asset Loading");
      try {
        jsonString = File(".\\assets\\json\\litere.json").readAsStringSync();
      } catch (e) {
        log("Failed to load './assets/json/litere.json\nERROR ${e.toString()}",
            time: DateTime.now(), name: "ERROR", level: 10);
        return;
      }
        log("Loaded `./assets/json/litere.json`",
            time: DateTime.now(), name: "Asset Loading");
    } else if (Platform.isLinux) {
      log("Loading `./assets/json/litere.json`",
          time: DateTime.now(), name: "Asset Loading");
      try {
        jsonString = File("./assets/json/litere.json").readAsStringSync();
      } catch (e) {
        log("Failed to load './assets/json/litere.json\nERROR ${e.toString()}",
            time: DateTime.now(), name: "ERROR", level: 10);
      }
        log("Loaded `./assets/json/litere.json`",
            time: DateTime.now(), name: "Asset Loading");
    }

    final Map<String, dynamic> jsonMap = decoder.convert(jsonString);

    var value = jsonMap["letters"];
    if (value != null) {
      value.forEach((item) => letters.add(
          Letter(character: item["letter"], audioPath: item["recording"])));
    }
  }
}

class FunFacts {
  static List<FunFact> facts = List.empty(growable: true);

  FunFacts.initialize() {
    const JsonDecoder jsonDecoder = JsonDecoder();
    String jsonString = "";

    if (Platform.isWindows) {
      log("Loading `./assets/json/stiati_ca.json`",
          time: DateTime.now(), name: "Asset Loading");
      jsonString = File(".\\assets\\json\\stiati_ca.json").readAsStringSync();
      log("Loaded `./assets/json/stiati_ca.json`",
          time: DateTime.now(), name: "Asset Loading");
    } else if (Platform.isLinux) {
      log("Loading `./assets/json/stiati_ca.json`",
          time: DateTime.now(), name: "Asset Loading");
      jsonString = File("./assets/json/stiati_ca.json").readAsStringSync();
      log("Loaded `./assets/json/stiati_ca.json`",
          time: DateTime.now(), name: "Asset Loading");
    }

    final Map<String, dynamic> jsonMap = jsonDecoder.convert(jsonString);

    var value = jsonMap["stiati_ca"];
    if (value != null) {
      value.forEach((item) => facts
          .add(FunFact(text: item["string"], audioPath: item["audio_path"])));
    }
  }
}

class ProgressStorage {
  static List<LevelProgress> levels = List.empty(growable: true);

  ProgressStorage.create() {
    log("Creating Progress Storage",
        time: DateTime.now(), name: "Asset Loading");
    levels.add(LevelProgress());

    levels[0].comunicare.parts["romana"] = CollectionProgress();
    levels[0].comunicare.parts["romana"]!.parts["litere"] = Progress(31, 23);
    levels[0].comunicare.parts["romana"]!.parts["vocale"] = Progress(31, 15);

    levels[0].matematica.parts["aritmetica"] = CollectionProgress();
    levels[0].matematica.parts["aritmetica"]!.parts["operatii"] = Progress(25, 20);
    levels[0].matematica.parts["aritmetica"]!.parts["fractii"] = Progress(25, 0);
    levels[0].matematica.parts["aritmetica"]!.parts["siruri"] = Progress(25, 0);
    levels[0].matematica.parts["aritmetica"]!.parts["formare"] = Progress(25, 0);
    levels[0].matematica.parts["geometrie"] = CollectionProgress();

    levels.add(LevelProgress());
    levels.add(LevelProgress());
  }
}

class StorageManager {
  StorageManager() {
    Letters.initialize();
    FunFacts.initialize();
    ProgressStorage.create();
  }
}
