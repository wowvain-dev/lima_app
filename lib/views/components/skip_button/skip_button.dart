import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../app/router.gr.dart';

/// TODO(wowvain-dev):  MODULARIZE PROPERLY (WRAPPER AND MODALS)

class SkipButton extends StatefulWidget {
  SkipButton({required this.modal, required this.exercise});

  void Function(BuildContext, void Function()) modal;
  PageRouteInfo<dynamic> exercise;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> with TickerProviderStateMixin {
  _SkipButtonState();

  Color _skip = const Color(0xFFaaaaaa);
  AnimationController? _controller;
  Animation<Color?>? _animation;
  AnimationController? _controller_size;
  Animation<double?>? _animation_size;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _controller_size = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _animation = ColorTween(
      begin: const Color(0xFFcccccc),
      end: const Color(0xFFfefefe),
    ).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _animation_size = Tween<double>(
      begin: size.width / 70,
      end: size.width / 65,
    ).animate(_controller_size!)
      ..addListener(() {
        setState(() {});
      });
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _controller!.forward();
          _controller_size!.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _controller!.reverse();
          _controller_size!.reverse();
        });
      },
      child: GestureDetector(
        onTap: () {
          context.router.pop(context);
          context.router.push(widget.exercise);
        },
        child: AnimatedContainer(
          height: 50,
          margin: const EdgeInsets.only(top: 10),
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          child: Text("Treceţi Peste",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: _animation!.value
                  , fontSize: _animation_size!.value)),
        ),
      ),
    );
  }
}
