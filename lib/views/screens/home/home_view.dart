/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';

/// Widgets
import 'package:flutter_switch/flutter_switch.dart';
import 'package:keyboard_event/keyboard_event.dart';

/// The viewmodel of this view
import './home_viewmodel.dart';

/// Storage dependencies
import 'package:realm/realm.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
    model.focusNode.requestFocus();
    model.size = MediaQuery.of(context).size;
    return Scaffold(
      body: Focus(
        focusNode: model.focusNode,
        onKey: (_, event) {
          if (event.data.physicalKey == PhysicalKeyboardKey.arrowRight &&
              model.pageIndex < 2 &&
              model.canGoRight) {
            model.pageController.nextPage(
                duration: const Duration(milliseconds: 500), curve: Curves.ease);
            model.pageIndex++;
            model.canGoRight = false;
            model.canGoLeft = false;
            model.notifyListeners();
            Future.delayed(const Duration(milliseconds: 450), model.scroll);
            model.notifyListeners();
          }
          if (event.data.physicalKey == PhysicalKeyboardKey.arrowLeft &&
              model.pageIndex > 0 &&
              model.canGoLeft) {
            model.pageController.previousPage(
                duration: const Duration(milliseconds: 500), curve: Curves.ease);
            model.pageIndex--;
            model.canGoRight = false;
            model.canGoLeft = false;
            model.notifyListeners();
            Future.delayed(const Duration(milliseconds: 450), model.scroll);
            model.notifyListeners();
          }
          model.notifyListeners();
          return KeyEventResult.handled;
        },
        child: Column(children: [
          const SizedBox(height: 60),
          Expanded(
            child: PageView(
                controller: model.pageController,
                onPageChanged: (val) {
                  model.pageIndex = val;
                  model.notifyListeners();
                },
                scrollDirection: Axis.horizontal,
                children: [_Page1(model), _Page2(model), _Page3(model)]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 30,
                    // color: Colors.white24,
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: model.pageIndex > 0 && model.canGoLeft
                        ? () async {
                            model.pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                            model.pageIndex--;
                            model.canGoRight = false;
                            model.canGoLeft = false;
                            model.notifyListeners();
                            Future.delayed(
                                const Duration(milliseconds: 450), model.scroll);
                            model.notifyListeners();
                          }
                        : null),
                const SizedBox(width: 32),
                Icon(Icons.circle,
                    size: 15,
                    color: model.pageIndex == 0
                        ? const Color(0xFFF5F5F5)
                        : Colors.white54),
                const SizedBox(width: 16),
                Icon(Icons.circle,
                    size: 15,
                    color: model.pageIndex == 1
                        ? const Color(0xFFF5F5F5)
                        : Colors.white54),
                const SizedBox(width: 16),
                Icon(Icons.circle,
                    size: 15,
                    color: model.pageIndex == 2
                        ? const Color(0xFFF5F5F5)
                        : Colors.white54),
                const SizedBox(width: 32),
                IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: model.pageIndex < 2 && model.canGoRight
                        ? () async {
                            model.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            model.pageIndex++;
                            model.canGoRight = false;
                            model.canGoLeft = false;
                            model.notifyListeners();
                            Future.delayed(
                                const Duration(milliseconds: 450), model.scroll);
                            model.notifyListeners();
                          }
                        : null),
              ],
            ),
          )
        ]),
      ),
    );
  },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class _Page1 extends StatelessWidget {
  _Page1(this.model);
  HomeViewModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Salut!',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: FontWeight.w400, color: const Color(0xFFF5F5F5), 
                fontSize: model.size.width / 25),
          ),
          Text(
            'Apăsaţi pe săgeata spre dreapta',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white60, 
                  fontSize: model.size.width / 70
                ),
          ),
        ]);
  }
}

class _Page2 extends StatelessWidget {
  _Page2(this.model);

  /// The view model of this screen.
  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    model.size = MediaQuery.of(context).size;
    var size = model.size;

    /// Initializing the button sizes
    for (int i = 0; i < 3; i++) {
      if (model.buttonSizes[i]!.width == 0 ||
          model.isMouseOverButton == false) {
        model.buttonSizes[i] = Size(size.width / 5, size.width / 6);
      }
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MouseRegion(
                    onEnter: (event) {
                      model.buttonSizes[0] =
                          Size(size.width / 4, size.width / 5);
                      model.isMouseOverButton = true;
                      model.notifyListeners();
                    },
                    onExit: (event) {
                      model.buttonSizes[0] =
                          Size(size.width / 5, size.width / 6);
                      model.isMouseOverButton = false;
                      model.notifyListeners();
                    },
                    child: GestureDetector(
                      onTap: () {
                        model.buttonSizes[0] = 
                          Size(size.width / 4.5, size.width / 5.5);
                        model.notifyListeners();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          model.buttonSizes[0] = Size(size.width / 4, size.width / 5);
                        model.notifyListeners();
                        }).then(
                          // (_) => context.router.push(const Level1View())
                          (_) {
                            Future.delayed(const Duration(milliseconds: 100), 
                              () => showModal(context, model: model, level: 'Invatacel')
                            );
                          }
                        );
                      }, 
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.ease,
                        width: model.buttonSizes[0]!.width,
                        height: model.buttonSizes[0]!.height,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9B1FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Învățăcel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          color: const Color(0xFF2A2B2A),
                                          fontSize: size.width / 50))
                            ]),
                      ),
                    )),
                SizedBox(width: size.width / 35),
                MouseRegion(
                  onEnter: (event) {
                    model.buttonSizes[1] = Size(size.width / 4, size.width / 5);
                    model.isMouseOverButton = true;
                    model.notifyListeners();
                  },
                  onExit: (event) {
                    model.buttonSizes[1] = Size(size.width / 5, size.width / 6);
                    model.isMouseOverButton = false;
                    model.notifyListeners();
                  },
                  child: GestureDetector(
                      onTap: () {
                        model.buttonSizes[1] = 
                          Size(size.width / 4.5, size.width / 5.5);
                        model.notifyListeners();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          model.buttonSizes[1] = Size(size.width / 4, size.width / 5);
                        model.notifyListeners();
                        });
                          // (_) => context.router.push(const Level2View())
                        //);
                        
                      }, 
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                    width: model.buttonSizes[1]!.width,
                    height: model.buttonSizes[1]!.height,
                    decoration: BoxDecoration(
                        color: const Color(0xFFCB93FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Cunoscător',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: const Color(0xFF2A2B2A),
                                      fontSize: size.width / 50))
                        ]),
                  )),
                ),
                SizedBox(width: size.width / 35),
                MouseRegion(
                  onEnter: (event) {
                    model.buttonSizes[2] = Size(size.width / 4, size.width / 5);
                    model.isMouseOverButton = true;
                    model.notifyListeners();
                  },
                  onExit: (event) {
                    model.buttonSizes[2] = Size(size.width / 5, size.width / 6);
                    model.isMouseOverButton = false;
                    model.notifyListeners();
                  },
                  child: GestureDetector(
                      onTap: () {
                        model.buttonSizes[2] = 
                          Size(size.width / 4.5, size.width / 5.5);
                        model.notifyListeners();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          model.buttonSizes[2] = Size(size.width / 4, size.width / 5);
                        model.notifyListeners();
                        }).then(
                          (_) => context.router.push(const Level2View())
                        );
                        
                      }, 
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                    width: model.buttonSizes[2]!.width,
                    height: model.buttonSizes[2]!.height,
                    decoration: BoxDecoration(
                        color: const Color(0xFFBF7CFF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Expert',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: const Color(0xFF2A2B2A),
                                      fontSize: size.width / 50))
                        ]),
                  )),
                ),
              ])
        ]);
  }
}

class _Page3 extends StatelessWidget {
  _Page3(this.model);

  /// The view model of this screen.
  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text('Page 3')]);
  }
}

void showModal(
  BuildContext context, 
  {
    void Function()? callback, 
    required HomeViewModel model, 
    required String level}) {
  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
        ),
        contentPadding: const EdgeInsets.only(top: 10), 
        title: null, 
        content: Container(
          height: model.size.height / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32, top: 16), 
                  child: Text("Doriți să continuați ca $level?", style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: const Color(0xFFF5F5F5)
                  ))
                ),
              ), 
              const SizedBox(height: 32),
              Row(
                mainAxisSize: MainAxisSize.max, 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        child: Text('Nu', textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: const Color(0xFFF5F5F5)
                          )
                        ), 
                      ), 
                      onTap: () {
                        Navigator.pop(context);
                      }
                    ),
                  ), 
                  // SizedBox(width: model.size.width / 10),
                  Expanded(
                    child: GestureDetector(child: Container(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[300]!),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
                        ),
                        child: Text('Da', textAlign: TextAlign.center, 
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: const Color(0xFFF5F5F5)
                        ))
                      )
                    )),
                  ), 
                ]
              )
            ]
          )
        )
      );
    });
}