import 'package:flutter/material.dart';

class VerifButton extends StatefulWidget {
  VerifButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height
  });

  void Function() onPressed;
  Widget child;
  double? width;
  double? height;

  @override
  State<VerifButton> createState() => _VerifButtonState();
}

class _VerifButtonState extends State<VerifButton> {
  LinearGradient buttonBG = const LinearGradient(
    colors: [Color(0xFFFFFFFF)]
  );

  @override
  void initState() {
    buttonBG = const LinearGradient(
      colors: [
        Color(0xFF5D69BE),
        Color(0xFFC89FEB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
          onExit: (_) {
            setState(() {
              buttonBG = const LinearGradient(
                colors: [Color(0xFF5D69BE), Color(0xFFC89FEB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );
            });
          },
          onEnter: (_) {
            setState(() {
              super.setState(() {});
              buttonBG = const LinearGradient(
                colors: [
                  Color(0xFF576182),
                  Color(0xFF1FC5A8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );
            });
          },
          child: GestureDetector(
              onTap: () {
                setState(() {
                  Future.delayed(Duration.zero, () {
                    buttonBG = const LinearGradient(
                        colors: [
                          Color(0xFF5D69BE),
                          Color(0xFFC89FEB)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight);
                  }).whenComplete(() {
                    Future.delayed(
                        const Duration(milliseconds: 200), () {
                      setState(() {
                        buttonBG = const LinearGradient(
                          colors: [
                            Color(0xFF576182),
                            Color(0xFF1FC5A8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        );
                      });
                    });
                  });
                });

                widget.onPressed();

              },
              child: AnimatedContainer(
                height: widget.height,
                  width: widget.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x99000000),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 20),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    gradient: buttonBG,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: Center(child: widget.child)
          )));
  }
}
