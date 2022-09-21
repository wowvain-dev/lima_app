/// Flutter
import 'package:flutter/material.dart';
import 'package:scoalafun/app/locator.dart';
import 'package:scoalafun/services/layout_manager.dart';

/// Architectural Dependencies
import 'package:stacked/stacked.dart';

/// The viewmodel of this view
import './home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
        l<LayoutManager>().updateLayout(context);
        return Scaffold(
            body: Container(
                child: l<LayoutManager>().layout == Layout.vertical
                    ? _VerticalLayout()
                    : _HorizontalLayout()));
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
                        onPressed: () => {}),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
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
                        onPressed: () => {}),
                  ),
                ),
                SizedBox(height: 8),
                Text('Limba si Comunicare')
              ],
            ),
            const SizedBox(width: 128),
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
