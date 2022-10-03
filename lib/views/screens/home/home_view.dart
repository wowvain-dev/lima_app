/// Flutter
import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/services/layout_manager.dart';
import 'package:realm/realm.dart';

/// Architectural Dependencies
import 'package:stacked/stacked.dart';
import 'package:lima/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter_switch/flutter_switch.dart';

/// The viewmodel of this view
import './home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final app = App(AppConfiguration('lima_app-qjrix'));

  @override
  Widget build(BuildContext context) {
    print(app.currentUser!.profile.email);
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
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  _HorizontalLayout({required this.model});

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ROMÂNĂ',
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
              // model.pageIndex = val;
              // model.notifyListeners();
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
                onPressed: model.pageIndex > 0
                    ? () {
                        model.pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                        model.pageIndex--;
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
                onPressed: model.pageIndex < 2
                    ? () {
                        model.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        model.pageIndex++;
                        model.notifyListeners();
                      }
                    : null),
          ],
        ),
      )
    ]);
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
          Text( model.isEnglish
          ? 'Hello!' : 'Salut!',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: FontWeight.w400, color: Color(0xFFF5F5F5)),
          ),
          Text( model.isEnglish 
          ? 'Press on the right arrow' : 'Apăsaţi pe săgeata spre dreapta',
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Page2')]);
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
