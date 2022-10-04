/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Architectural Dependencies
import 'package:lima/app/locator.dart';
import 'package:lima/services/layout_manager.dart';
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

  final app = App(AppConfiguration('lima_app-qjrix'));

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
        l<LayoutManager>().updateLayout(context);
        return Scaffold(
            body: Container(
                child: l<LayoutManager>().layout == Layout.vertical
                    ? _VerticalLayout()
                    : _HorizontalLayout(model: model)));
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Focus(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 145,
                    height: 145,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: IconButton(
                          hoverColor: Colors.transparent,
                          iconSize: 50,
                          icon: const Icon(Icons.menu_book_sharp,
                              color: Colors.white),
                          onPressed: () => {context.router.push(LimbaView())}),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Limba si Comunicare')
                ],
              ),
              const SizedBox(height: 64),
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: IconButton(
                        hoverColor: Colors.transparent,
                        iconSize: 50,
                        icon: const Icon(Icons.square_foot_rounded,
                            size: 50, color: Colors.white),
                        onPressed: () => {}),
                  ),
                ),
                SizedBox(height: 8),
                Text('Matematica')
              ]),
            ]),
      ),
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  _HorizontalLayout({required this.model});

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    model.focusNode.requestFocus();
    return Focus(
      focusNode: model.focusNode,
      onKey: (_, event) {
        if (event.data.physicalKey == PhysicalKeyboardKey.arrowRight
          && model.pageIndex < 2 && model.canGoRight
        ) {
          model.pageController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
          model.pageIndex++;
          model.canGoRight = false;
          model.canGoLeft = false;
          model.notifyListeners();
          Future.delayed(const Duration(milliseconds: 450), model.scroll);
          model.notifyListeners();
        }
        if (event.data.physicalKey == PhysicalKeyboardKey.arrowLeft
          && model.pageIndex > 0 && model.canGoLeft
        ) {
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
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ROMÂNĂ",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: model.isEnglish
                            ? Colors.white54
                            : const Color(0xFFF5F5F5))),
                const SizedBox(width: 8),
                FlutterSwitch(
                    value: model.isEnglish,
                    activeText: "ENG",
                    inactiveText: "ROM",
                    height: 30,
                    width: 60,
                    duration: const Duration(milliseconds: 100),
                    onToggle: (val) {
                      model.isEnglish = val;
                      model.notifyListeners();
                    }),
                const SizedBox(width: 8),
                Text("ENGLEZĂ",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: !model.isEnglish
                            ? Colors.white54
                            : const Color(0xFFF5F5F5)))
              ],
            )),
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
                  icon: Icon(Icons.arrow_back_ios_new),
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
                  icon: Icon(Icons.arrow_forward_ios),
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
            model.isEnglish ? 'Hello!' : 'Salut!',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: FontWeight.w400, color: const Color(0xFFF5F5F5)),
          ),
          Text(
            model.isEnglish
                ? 'Press on the right arrow'
                : 'Apăsaţi pe săgeata spre dreapta',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white60),
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
    for (int i = 0; i < 3; i ++){
        if (model.buttonSizes[i]!.width == 0 || model.isMouseOverButton == false) {
        model.buttonSizes[i] = Size(size.width / 5, size.width / 6);
      }
    }
    print('${model.buttonSizes[0]}');
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
                      model.buttonSizes[0] = Size(size.width / 4, size.width / 5);
                      model.isMouseOverButton = true;
                      model.notifyListeners();
                    },
                    onExit: (event) {
                      model.buttonSizes[0] = Size(size.width / 5, size.width / 6);
                      model.isMouseOverButton = false;
                      model.notifyListeners();
                    },
                    child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  width: model.buttonSizes[0]!.width,
                  height: model.buttonSizes[0]!.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Învățăcel',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                  color: Color(0xFF2A2B2A), 
                                  fontSize: size.width / 50))
                      ]),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD9B1FF),
                      borderRadius: BorderRadius.circular(10)),
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
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  width: model.buttonSizes[1]!.width,
                  height: model.buttonSizes[1]!.height,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Cunoscător',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: Color(0xFF2A2B2A), 
                                    fontSize: size.width / 50))
                        ]),
                    decoration: BoxDecoration(
                        color: const Color(0xFFCB93FF),
                        borderRadius: BorderRadius.circular(10)),
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
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  width: model.buttonSizes[2]!.width,
                  height: model.buttonSizes[2]!.height,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Expert',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Color(0xFF2A2B2A), 
                                    fontSize: size.width / 50
                                  ))
                        ]),
                    decoration: BoxDecoration(
                        color: const Color(0xFFBF7CFF),
                        borderRadius: BorderRadius.circular(10)),
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
        children: [Text('Page 3')]);
  }
}
