import 'dart:collection';
import 'dart:math';
import 'package:stack/stack.dart';
import 'package:flutter/material.dart' hide Stack;
import 'package:flutter_svg/flutter_svg.dart';

/// The operators usable inside the expression tree.
enum Operator {
  plus,
  minus,
  mul,
  div,
}

enum Options {
  canGetNegative,
}

extension SignPrinting on Operator {
  String get symbol {
    switch (this) {
      case Operator.plus:
        return '+';
      case Operator.minus:
        return '-';
      case Operator.mul:
        return '×';
      case Operator.div:
        return ':';
    }
  }
}

/// Binary Tree node describing a mathematical expression where every
/// non-leaf node contains a sign and every leaf contains a number.
class ExpressionNode {
  ExpressionNode(this.sign, this.value);

  /// The sign of this node or null.
  Operator? sign;

  /// The value of this node or null.
  int? value;

  ExpressionNode? left;
  ExpressionNode? right;
  ExpressionNode? parent;

  @override
  String toString() {
    return _diagram(this);
  }

  @override
  bool operator ==(covariant ExpressionNode other) {
    if (other.runtimeType == ExpressionNode) {
      if (value == other.value && sign == other.sign)
        return true;
      else {
        return false;
      }
    } else {
      return false;
    }
  }

  String _diagram(
    ExpressionNode? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.left == null && node.right == null) {
      return '$root ${node.value ?? node.sign!.symbol}\n';
    }
    final a = _diagram(
      node.right,
      '$top ',
      '$top┌──',
      '$top│ ',
    );
    final b = '$root${node.value ?? node.sign!.symbol}\n';
    final c = _diagram(
      node.left,
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );

    return '\n$a$b$c';
  }

  /// Prints the expression with an infix traversal
  String infix() {
    if (sign == null && value == null) {
      return '';
    }

    String a = '';

    if (sign != null) {
      if (height() > 3) {
        a = '{${left!.infix()}${sign!.symbol}${right!.infix()}}';
      } else if (height() == 3) {
        a = '[${left!.infix()}${sign!.symbol}${right!.infix()}]';
      } else if (height() == 2) {
        a = '(${left!.infix()}${sign!.symbol}${right!.infix()})';
      }
    } else {
      a = '$value$a';
    }
    return a;
  }

  /// Returns the height of a node
  int height() {
    int left, right;
    if (this.left == null) {
      left = 0;
    } else {
      left = this.left!.height();
    }
    if (this.right == null) {
      right = 0;
    } else {
      right = this.right!.height();
    }

    return max(left, right) + 1;
  }

  /// Checks if a node is an operator node.
  bool isOperator() {
    if (sign != null && value == null) {
      return true;
    }

    if (sign == null && value != null) {
      return false;
    }

    if (sign == null && value == null) {
      return false;
    }

    if (sign != null && value != null) {
      throw Exception("A node can't have both a sign and a value.");
    }

    return false;
  }
}

/// A tree containing the root node and its own depth.
class ExpressionTree {
  /// Empty Constructor
  /// Defaults the root of the tree to `null` and the height to `0`
  ExpressionTree()
      : allowedOperators = List.empty(),
        minimumAllowedOperand = 0,
        maximumAllowedOperand = 0,
        maximumPossibleDepth = 0 {
    root = null;
  }

  ExpressionTree.random(

      /// allowed operators
      List<Operator> operators,

      /// the start of the interval allowed for the numbers
      int start,

      /// the end of the interval allowed for the numbers
      int end,

      /// is the max depth reached?
      int maxDepth,

      /// the options of the tree
      this.options)
      : allowedOperators = operators,
        minimumAllowedOperand = start,
        maximumAllowedOperand = end,
        maximumPossibleDepth = maxDepth {
    root = randomExpression(operators, start, end, maxDepth);
  }

  ExpressionTree.randomUsingSource(ExpressionTree source)
      : allowedOperators = source.allowedOperators,
        options = source.options,
        minimumAllowedOperand = source.minimumAllowedOperand,
        maximumAllowedOperand = source.maximumAllowedOperand,
        maximumPossibleDepth = source.maximumPossibleDepth {
    root = randomExpression(
        source.allowedOperators,
        source.minimumAllowedOperand,
        source.maximumAllowedOperand,
        source.maximumPossibleDepth);
  }

  ExpressionNode? root;
  List<Operator> allowedOperators;
  List<Options>? options;
  int minimumAllowedOperand;
  int maximumAllowedOperand;
  int maximumPossibleDepth;
  int get depth => getDepth(root);

  static void _buildInOrderQueue(Queue<ExpressionNode?> queue, ExpressionNode? n) {
     if (n == null) return;

     _buildInOrderQueue(queue, n.left);
     queue.add(n);
     _buildInOrderQueue(queue, n.right);
  }

  /// Returns the first (inorder) operator node that doesn't have both
  /// operands.
  static ExpressionNode? getFirstFreeOperatorLeafNode(ExpressionNode? n) {
    Queue<ExpressionNode?> queue = Queue();

    _buildInOrderQueue(queue, n);

    while (queue.isNotEmpty) {
      if (queue.first!.isOperator() && (queue.first!.left == null || queue.first!.right == null)) {
        return queue.first!;
      }
      queue.removeFirst();
    }

    return null;
  }

  /// Adds a new leaf node to the tree (to the first "free" operator node).
  void addLeafNode(ExpressionNode? node) {
    if (node == null) return;
    if (root == null) {
      root = node;
      root!.parent = null;
      root!.left = null;
      root!.right = null;
    } else {
      ExpressionNode? lastOperatorLeaf = getFirstFreeOperatorLeafNode(root);
      if (lastOperatorLeaf != null) {
        if (lastOperatorLeaf.left == null) {
          node.parent = lastOperatorLeaf;
          lastOperatorLeaf.left = node;
        } else {
          if (lastOperatorLeaf.right == null) {
            node.parent = lastOperatorLeaf;
            lastOperatorLeaf.right = node;
          }
        }
      }
    }
  }

  /// Returns the depth of a binary tree.
  static int getDepth(ExpressionNode? node) {
    if (node == null) {
      return 0;
    } else {
      int lDepth = getDepth(node.left);
      int rDepth = getDepth(node.right);

      if (lDepth > rDepth) {
        return lDepth + 1;
      } else {
        return rDepth + 1;
      }
    }
  }

  /// Return a node randomly containing either a sign node or a value node with
  /// its value found in a set interval
  static ExpressionNode randomOperandOrOperator(

      /// allowed operators
      List<Operator> operators,

      /// the start of the interval allowed for the numbers
      int start,

      /// the end of the interval allowed for the numbers
      int end,

      /// is the max depth reached?
      bool maxDepth) {
    if (operators.length == 1) {
      maxDepth = true;
    }

    if (maxDepth == true) {
      return ExpressionNode(null, Random().nextInt(end - start) + start);
    } else {
      int percentage = Random().nextInt(100) + 1;
      if (percentage <= 30) {
        return ExpressionNode(null, Random().nextInt(end - start) + start);
      } else {
        return ExpressionNode(
            operators[Random().nextInt(operators.length)], null);
      }
    }
  }

  /// Evaluate an expression tree and return its value.
  static int evaluate(ExpressionNode? node) {
    if (node == null) {
      return 1;
    }

    if (node.left == null && node.right == null) {
      return node.value ?? 0;
    }

    /// Evaluate left subtree
    int l_val = evaluate(node.left);

    /// Evaluate right subtree
    int r_val = evaluate(node.right);

    if (node.sign == Operator.plus) {
      return l_val + r_val;
    }

    if (node.sign == Operator.minus) {
      return l_val - r_val;
    }

    if (node.sign == Operator.mul) {
      return l_val * r_val;
    }

    if (node.sign == Operator.div) {
      if (r_val == 0) return 0;
      return l_val ~/ r_val;
    }

    return 0;
  }

  /// Returns a tree containing a randomly generated expression based on
  /// the operators given as parameters, the interval of the numeric values
  /// and the maximum depth of the tree.
  ExpressionNode? randomExpression(

      /// allowed operators
      List<Operator> operators,

      /// the start of the interval allowed for the numbers
      int start,

      /// the end of the interval allowed for the numbers
      int end,

      /// the max depth
      int maxDepth) {
    ExpressionTree expression = ExpressionTree();
    do {
      print(expression.root);
      var lastNode = getFirstFreeOperatorLeafNode(expression.root);
      if (lastNode == null) {
        expression.addLeafNode(
            ExpressionNode(operators[Random().nextInt(operators.length)], null)
        );
        continue;
      }

      var op = randomOperandOrOperator(
          operators, start, end, expression.depth >= maxDepth);

      if (lastNode.left == null) {
        expression.addLeafNode(op);
        continue;
      }

      int val = ExpressionTree.evaluate(lastNode.left);

      // TODO(wowvain-dev): finishing touches required

      if (lastNode == ExpressionNode(Operator.minus, null)) {
        print("the left side of the minus is ${lastNode.left}");
        lastNode.right = val >= 1
            ? ExpressionNode(null, Random().nextInt(val))
            : ExpressionNode(null, 0);
        print("left side of minus: ${ExpressionTree.evaluate(lastNode.left)}");
        continue;
      }

      if (lastNode != ExpressionNode(Operator.div, null)) {
        expression.addLeafNode(op);
        continue;
      }

      if (lastNode!.left != null) {
        if (val == 0) {
          expression.addLeafNode(ExpressionNode(null, 1));
          continue;
        }

        print("val: $val");
        List<int> divisors = List.empty(growable: true);

        int i = 1;
        while (i * i <= val) {
          if (val % i == 0) {
            if (i * i == val) {
              divisors.add(i);
              break;
            }
            divisors.addAll([i, val ~/ i]);
            print(divisors);
          }
          i++;
        }
        expression
            .addLeafNode(ExpressionNode(null, (divisors..shuffle()).first));
        divisors.clear();
        continue;
      }

      // expression.addLeafNode(op);
    } while (getFirstFreeOperatorLeafNode(expression.root) != null);
    return expression.root;
  }

  /// Transforms the tree into a readable natural mathematical expression.
  String get expression {
    if (root == null) {
      return "".toString();
    } else {
      var expr = root!.infix();
      if (expr.contains('(')) {
        expr = expr.substring(1, expr.length - 1);
      }

      var chars = expr.runes.map((e) => String.fromCharCode(e)).toList();
      var test = "";

      int i = 0, j = chars.length - 1;

      int countParanthesis = () {
        return ('('
            .allMatches(String.fromCharCodes(chars.map((e) => e.codeUnitAt(0))))
            .length);
      }.call();

      // List<Character> chrs = chars.map((e) => Character(e)).toList();
      //
      // for (int i = 0; i < chrs.length; i++) {
      //   int close = chrs.indexWhere((element) {
      //     return element.value == ')' && element.used == false;
      //   });
      //
      //   if (close == -1) {
      //     break;
      //   }
      //   chrs[close].used = true;
      //   int open = chrs.lastIndexWhere((element) {
      //     return element.value == '(' && element.used == false;
      //   }, close);
      // }

      var res = "";

      for (int a = 0; a < chars.length; a++) {
        res = "$res${chars[a]}";
      }

      return res;
    }
  }

  @override
  String toString() {
    return root.toString();
  }
}

class Character {
  Character(this.value, {this.used = false});
  String value;
  bool used;

  @override
  String toString() {
    return value;
  }
}
