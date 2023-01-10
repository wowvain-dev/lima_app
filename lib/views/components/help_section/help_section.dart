import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HelpSection extends StatefulWidget
{
  HelpSection(
    {
      required this.showAnswer,
      required this.modal,
    });

  void Function() showAnswer;
  void Function(BuildContext, void Function()) modal;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _HelpSectionState(
    showAnswer: showAnswer,
    modal: modal
  );
}

class _HelpSectionState extends State<HelpSection>
  with TickerProviderStateMixin {

  _HelpSectionState({
    required this.showAnswer,
    required this.modal,
  });

  void Function() showAnswer;
  void Function(BuildContext, void Function()) modal;

  AnimationController? _controller1;
  AnimationController? _controller2;
  Animation<Color?>? _animation1;
  Animation<Color?>? _animation2;

  @override
  void initState() {
    _controller1 = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 200)
    );

    _controller2 = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 200)
    );

    _animation1 = ColorTween(
      begin: const Color(0xFFcccccc),
      end: const Color(0xFFfefefe),
    ).animate(_controller1!)
      ..addListener(() {
        setState(() {});
      });

    _animation2 = ColorTween(
      begin: const Color(0xFFcccccc),
      end: const Color(0xFFfefefe),
    ).animate(_controller2!)
      ..addListener(() {
        setState(() {
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width / 4),
      height: size.height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
                child: MouseRegion(
                  onEnter: (_) {
                    _controller1?.forward();
                  },
                  onExit: (_) {
                    _controller1?.reverse();
                  },
                  child: GestureDetector(
                    onTap: () {
                      modal;
                    },
                    child: Text("Ce trebuie să fac?",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                            color: _animation1?.value,
                            fontSize: size.width / 60)),
                  ),
                )),
          ),
          const VerticalDivider(
            color: Colors.grey,
            width: 2,
          ),
          Expanded(
            child: Center(
                child: MouseRegion(
                  onEnter: (_) {
                    _controller2?.forward();
                  },
                  onExit: (_) {
                    _controller2?.reverse();
                  },
                  child: GestureDetector(
                    onTap: () {
                      showAnswer();
                    },
                    child: Text("Arată răspunsul",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                            color: _animation2?.value,
                            fontSize: size.width / 60)),
                  ),
                )),
          )
        ],
      ),
    );
  }

}