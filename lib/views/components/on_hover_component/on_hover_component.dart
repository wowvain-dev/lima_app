/// Flutter

import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {
  OnHover({
    Key? key, 
    required this.child
  });

  Widget child;

  @override  
  _OnHoverState createState() => _OnHoverState(child: child);
}

class _OnHoverState extends State<OnHover> 
  with SingleTickerProviderStateMixin {
  _OnHoverState({required this.child});

  AnimationController? controller;
  Animation? onTapAnimation;

  Widget child;

  bool isHovered = false;

  final hoveredTransform = Matrix4.identity()
    ..scale(1.2);
  Matrix4 transform = Matrix4.identity();

  @override
  void initState() {
    transform = Matrix4.identity();
    controller = AnimationController(vsync: this, 
      duration: const Duration(milliseconds: 100)
    );
    onTapAnimation = Tween<Matrix4>(
      begin: Matrix4.identity()..scale(1.2),
      end: Matrix4.identity()..scale(0.75), 
    ).animate(controller!);
    controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    var transform = isHovered 
      ? hoveredTransform 
      : Matrix4.identity();

    return GestureDetector(
      onTap: () {
        controller!.forward().whenCompleteOrCancel(() { 
          controller!.reverse();
        });
      },
      child: MouseRegion(
        onEnter: (_) => {
          setState(() {
            isHovered = true;
          })
        }, 
        onExit: (_) => {
          setState(() {
            isHovered = false;
          })
        }, 
        child: AnimatedContainer(
          transform: onTapAnimation!.value, 
          curve: Curves.ease,
          duration: const Duration(milliseconds: 250), 
          child: child
        )
      ),
    );
  }
}