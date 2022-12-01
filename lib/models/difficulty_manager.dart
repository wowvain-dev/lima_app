// import 'package:stack/stack.dart';

import 'dart:collection';

import 'package:lima/models/expression_tree.dart';

class Difficulty {

}

class ExpressionDifficulty extends Difficulty {
  /// members
  int _lowLimit = 0;
  int _maxLimit = 10;
  int _depth = 2;
  List<Operator> _allowedOperators = [
    Operator.minus, Operator.plus
  ];

  /// getters / setters
  int get lowLimit => _lowLimit;
  set lowLimit(int a) => _lowLimit = a;

  int get maxLimit => _maxLimit;
  set maxLimit(int a) => _maxLimit = a;

  int get depth => _depth;
  set depth(int a) => _depth = a;

  List<Operator> get allowedOperators => _allowedOperators;
  set allowedOperators(List<Operator> a) => _allowedOperators = a;
}

class DifficultyManager {
  ExpressionDifficulty operatii = ExpressionDifficulty();
}