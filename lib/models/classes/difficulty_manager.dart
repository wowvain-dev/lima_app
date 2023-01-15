// import 'package:stack/stack.dart';

import 'dart:collection';

import 'package:lima/models/classes/expression_tree.dart';

enum Order {
  ascending, 
  descending
}

/// U - unitati
/// ZU - zeci, unitati
/// SZU - sute, zeci, unitati
/// MSZU - mii, sute, zeci unitati
enum FormareType {
  U,
  ZU,
  SZU,
  MSZU
}

class Difficulty {

}

class ExpressionDifficulty extends Difficulty {
  // members
  int _lowLimit = 0;
  int _maxLimit = 10;
  int _depth = 2;
  List<Operator> _allowedOperators = [
    Operator.minus, Operator.plus
  ];

  // getters / setters
  int get lowLimit => _lowLimit;
  set lowLimit(int a) => _lowLimit = a;

  int get maxLimit => _maxLimit;
  set maxLimit(int a) => _maxLimit = a;

  int get depth => _depth;
  set depth(int a) => _depth = a;

  List<Operator> get allowedOperators => _allowedOperators;
  set allowedOperators(List<Operator> a) => _allowedOperators = a;
}

class FractionDifficulty extends Difficulty {
  FractionDifficulty();

  FractionDifficulty.withLimits({
    required this.lowLimit, 
    required this.maxLimit,
    this.allowWholes = false,
    this.onlySubunit = true
  }) : assert((allowWholes == true && onlySubunit == false) || (allowWholes == false));

  // members
  int lowLimit = 1;
  int maxLimit = 10;
  
  /// Whether you want or not to use whole parts in the fraction.
  /// If [equals] [false] then the fraction represent values 
  /// over than one in the format [a] / [b] where a > b instead of 
  /// [a/b] [a%b]/[b]
  bool allowWholes = false;
  // IGNORE THE RETARDED NAME, IM NOT SURE WHAT THE CORRECT
  // TERMINOLOGY IS IN ENGLISH  
  bool onlySubunit = true;

  /// TOOD(wowvain-dev): add getters / setters for all this shite
}

class OrderDifficulty extends Difficulty {
  // members
  int _lowLimit = 0;
  int _maxLimit = 10;
  int _length = 7;

  List<Order> _allowedOrders = [
    Order.descending, Order.ascending
  ];

  // getters / setters
  int get lowLimit => _lowLimit;
  set lowLimit(int a) => _lowLimit = a;

  int get maxLimit => _maxLimit;
  set maxLimit(int a) => _maxLimit = a;

  int get length => _length;
  set length(int a) => _length = a;

  List<Order> get allowedOrders => _allowedOrders;
  set allowedOrders(List<Order> a) => _allowedOrders = a;
}

class FormareDifficulty extends Difficulty {
  FormareType _type = FormareType.ZU;

  FormareType get type => _type;
  set type(FormareType a) => _type = a;
}



class DifficultyManager {
  ExpressionDifficulty operatii = ExpressionDifficulty();
  FractionDifficulty fractii = FractionDifficulty();
  OrderDifficulty ordine = OrderDifficulty();
  FormareDifficulty formare = FormareDifficulty();
}