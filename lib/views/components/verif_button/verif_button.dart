import 'package:flutter/material.dart';

class VerifButton extends StatefulWidget {
  VerifButton({required this.onPressed, required this.child});

  void Function() onPressed;
  Widget child;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _VerifButtonState(
    onPressed, child
  );
}

class _VerifButtonState extends State<VerifButton> {
  _VerifButtonState(this.onPressed, this.child);

  void Function() onPressed;
  Widget child;

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
    var size = MediaQuery.of(context).size;
    return MouseRegion(
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

                onPressed();

              },
              child: AnimatedContainer(
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
                  child: child
          )));
  }
}
