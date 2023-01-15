import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:icon_decoration/icon_decoration.dart';
import 'dart:math';

class CustomIconButton extends StatefulWidget {
  CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.duration,
    this.size = 25,
    this.gradient,
    this.stroke = const IconBorder(),
    this.background = const Color(0x00000000),
    this.sizeEnd = 25,
    this.gradientEnd,
    this.strokeEnd = const IconBorder(),
    this.backgroundEnd = const Color(0x00000000),
    this.rotate = false,
  });

  VoidCallback onPressed;
  IconData icon;

  IconBorder stroke = const IconBorder();
  IconBorder strokeEnd = const IconBorder();
  double size = 25;
  double sizeEnd = 25;
  double sizePress = 25;
  LinearGradient? gradient;
  LinearGradient? gradientEnd;
  Color? background = const Color(0x00000000);
  Color? backgroundEnd = const Color(0x00000000);
  Duration duration = const Duration(milliseconds: 0);

  bool? rotate;

  @override
  State<CustomIconButton> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIconButton>
  with TickerProviderStateMixin {

  LinearGradient? _gradient;

  AnimationController? _mainController;
  AnimationController? _onPressController;
  AnimationController? _rotationController;

  Animation<double?>? _sizeAnimation;
  Animation<double?>? _sizePressAnimation;
  Animation<Color?>? _colorAnimation;
  Animation<double?>? _strokeWidthAnimation;
  Animation<Color?>? _strokeColorAnimation;
  Animation<double?>? _rotateAnimation;

  double? _currentSize = 25;

  double? _strokeWidth = 0;
  double? _strokeWidthEnd;
  Color? _strokeColor = const Color(0xFF000000);
  Color? _strokeColorEnd;

  double _angle = 0;

  @override
  void initState() {

    widget.gradientEnd ??= widget.gradient;
    widget.backgroundEnd ??= widget.background;
    widget.sizeEnd ??= widget.size;
    widget.strokeEnd ??= widget.stroke;
    widget.sizePress ??= widget.size;

    _currentSize = widget.size;

    _strokeWidth = widget.stroke!.width;
    _strokeWidthEnd = widget.strokeEnd!.width;

    _strokeColor = widget.stroke!.color;
    _strokeColorEnd = widget.strokeEnd!.color;

    _mainController = AnimationController(vsync: this, duration: widget.duration);
    _onPressController = AnimationController(vsync: this, duration: widget.duration);
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _gradient = widget.gradient;

    if (widget.rotate == true) {
      _rotateAnimation = Tween<double?>( begin: _angle,
        end: _angle - 2*pi,
      ).chain(CurveTween(curve: Curves.ease)).animate(_rotationController!)
        ..addListener(() {
          setState(() {
            _angle = _rotateAnimation!.value ?? 0;
          });
        });
    }

    _sizeAnimation = Tween<double?>(
      begin: widget.size,
      end: widget.sizeEnd,
    ).animate(_mainController!)
      ..addListener(() {
        setState(() {
          _currentSize = _sizeAnimation!.value;
        });
      });

    _colorAnimation = ColorTween(
      begin: widget.background,
      end: widget.backgroundEnd,
    ).animate(_mainController!)
      ..addListener(() {
        setState(() {});
      });

    _strokeWidthAnimation = Tween<double?>(
      begin: widget.stroke!.width,
      end: widget.strokeEnd!.width,
    ).animate(_mainController!)
      ..addListener(() {
        setState((){});
      });

     _strokeColorAnimation = ColorTween(
      begin: widget.stroke!.color,
      end: widget.strokeEnd!.color,
    ).animate(_mainController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _mainController!.dispose();
    _onPressController!.dispose();
    _rotationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sizeAnimation = Tween<double?>(
      begin: widget.size,
      end: widget.sizeEnd,
    ).animate(_mainController!)
      ..addListener(() {
        setState(() {});
      });

    _strokeWidthAnimation = Tween<double?>(
      begin: widget.stroke!.width,
      end: widget.strokeEnd!.width,
    ).animate(_mainController!)
      ..addListener(() {
        setState((){});
      });

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        _mainController!.forward();
      },
      onHover: (_) {
        _mainController!.forward();
      },
      onExit: (_) {
        _mainController!.reverse();
      },
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
          _rotationController!.forward().whenComplete(() => _rotationController!.reset());
          _mainController!.forward(from: .3);
        },
        child: Transform.rotate(
          angle: widget.rotate == true ? _rotateAnimation!.value ?? 0 : 0,
          child: DecoratedIcon(
            icon: Icon(widget.icon,
              color: _colorAnimation!.value ?? const Color(0xFFffffff),
              size: _sizeAnimation!.value ?? 20,
            ),
            decoration: IconDecoration(
              gradient: _gradient,
              border: IconBorder(
                width: _strokeWidthAnimation!.value ?? 0,
                color: _strokeColorAnimation!.value ?? const Color(0xFFffffff),
              )
            ),
          ),
        )
      )
    );
  }
}