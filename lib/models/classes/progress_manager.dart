import 'package:flutter/material.dart';

class Progress {
  Progress(
      this.total, this.current
      );

  int total;
  int current;

  double get percentage => current / total;
  set percentage(double a) {
    current = (a * total).floor();
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class CollectionProgress {
  CollectionProgress();

  Map<String, Progress> parts = Map.identity();

  int get sumTotal {
    int total = 0;
    parts.forEach((_, val) {total += val.total;});
    return total;
  }

  int get sumCurrent {
    int current = 0;
    parts.forEach((_, val) {current += val.current;});
    return current;
  }

  double get percentage {
    return sumCurrent / sumTotal;
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class SubjectProgress {
  SubjectProgress();

  Map<String, CollectionProgress> parts = Map.identity();

  int get sumTotal {
    int total = 0;
    parts.forEach((_, val) => total += val.sumTotal);
    return total;
  }

  int get sumCurrent {
    int current = 0;
    parts.forEach((_, val) => current += val.sumCurrent);
    return current;
  }

  double get percentage {
    return sumCurrent / sumTotal;
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class LevelProgress {
  LevelProgress();

  SubjectProgress comunicare = SubjectProgress();
  SubjectProgress matematica = SubjectProgress();

  double get percentage {
    double total = 0;
    double current = 0;
    comunicare.parts.forEach((_, val) {total += val.sumTotal; current += val.sumCurrent;});
    matematica.parts.forEach((_, val) {total += val.sumTotal; current += val.sumCurrent;});
    return current / total;
  }

  @override
  String toString() => "${percentage * 100}%";
}