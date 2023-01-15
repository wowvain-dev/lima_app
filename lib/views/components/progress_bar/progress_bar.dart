import 'package:flutter/material.dart';
import 'package:lima/models/classes/storage_manager.dart';
import 'package:widget_mask/widget_mask.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({
    Key? key,
    required this.percentage,
    required this.width,
    this.background,
    this.backgroundFull,
    this.gradient,
    this.gradientFull,
    this.height,
  }) : assert(
  (background != null && gradient == null) || (gradient != null && background == null)
  ), assert(
  (background == null && backgroundFull == null) || (gradient == null && gradientFull == null)
  );

  Color? background;
  Color? backgroundFull;
  LinearGradient? gradient = const LinearGradient(
    colors: [
      Color(0xFFff1d25),
      Color(0xFF6049b0),
      Color(0xFF0082e6)
    ]
  );
  LinearGradient? gradientFull;
  double percentage;
  double? height;
  double? width;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
  with SingleTickerProviderStateMixin {

  AnimationController? loadingController;
  Animation<double?>? loadingAnimation;

  @override
  void initState() {
    loadingController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 400));

    loadingController!.addListener(() => setState(() {}));

    loadingAnimation = Tween<double>(
      begin: 0, end: ProgressStorage.levels[0].comunicare.parts["romana"]!.percentage
    ).chain(CurveTween(curve: Curves.ease)).animate(loadingController!);

    loadingController!.reset();
    loadingController!.forward();

    super.initState();
  }

  @override
  void dispose() {
    loadingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadingController!.forward();
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: const BoxDecoration(
          boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            spreadRadius: 2,
            blurRadius: 20,
            offset: Offset(0, 20),
          )
        ]
    ),
      child: Stack(
        children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2b2a),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
    Container(
    height: widget.height,
                width: loadingAnimation!.value! * widget.width!,
                decoration: BoxDecoration(
                  gradient: loadingAnimation!.value ==  widget.width ? widget.gradientFull : widget.gradient,
                  borderRadius: BorderRadius.circular(50)
                )
              ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color(0xFFfefefe),
                width: 2
              ),
            ),
            child: Center(
              child: Text("${(widget.percentage * 100).toStringAsFixed(2)}%", style:
                Theme.of(context).textTheme.headline6!.copyWith(
                  fontFamily: 'Dosis',
                  fontSize: MediaQuery.of(context).size.height / 40
                )
              )
            )
          ),
        ]
      )
    );
  }
}