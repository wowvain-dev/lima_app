import 'package:flutter/material.dart';

class Progress {
  Progress(
      this.ogTotal, this.ogCurrent
      );

  int ogTotal;
  int ogCurrent;

  int get total => ogTotal;
  int get current {
    print("getting current");
    return ogCurrent > ogTotal ? ogTotal : ogCurrent;
  }

  double get percentage => ogCurrent / ogTotal >= 1 ? 1 : ogCurrent / ogTotal;
  set percentage(double a) {
    ogCurrent = (a * ogTotal).floor();
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class CollectionProgress {
  CollectionProgress();

  Map<String, Progress> parts = Map.identity();

  int get total {
    int total = 0;
    parts.forEach((_, val) {total += val.ogTotal;});
    return total;
  }

  int get current {
    int current = 0;
    parts.forEach((_, val) {current += val.ogCurrent;});
    return current > total ? total : current;
  }

  double get percentage {
    return current / total >= 1 ? 1 : current / total;
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class SubjectProgress {
  SubjectProgress();

  Map<String, CollectionProgress> parts = Map.identity();

  int get total {
    int total = 0;
    parts.forEach((_, val) => total += val.total);
    return total;
  }

  int get current {
    int current = 0;
    parts.forEach((_, val) => current += val.current);
    return current > total ? total : current;
  }

  double get percentage {
    return current / total >= 1 ? 1 : current / total;
  }

  @override
  String toString() => "${(percentage * 100).toStringAsFixed(2)}%";
}

class LevelProgress {
  LevelProgress();

  SubjectProgress comunicare = SubjectProgress();
  SubjectProgress matematica = SubjectProgress();

  int get current {
    int current = 0;
    comunicare.parts.forEach((_, val) {current += val.current;});
    matematica.parts.forEach((_, val) {current += val.current;});
    return current > total ? total : current;
  }

  int get total {
    int total = 0;
    comunicare.parts.forEach((_, val) {total += val.total;});
    matematica.parts.forEach((_, val) {total += val.total;});
    return total;
  }

  double get percentage {
    return (current / total) >= 1 ? 1 : current / total;
  }

  @override
  String toString() => "${percentage * 100}%";
}