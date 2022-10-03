/// Flutter
import 'package:flutter/material.dart';
import 'package:lima/app/router.gr.dart';
import 'package:lima/views/screens/limba/limba_viewmodel.dart';

/// Architectural dependencies
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';

class LimbaView extends StatelessWidget {
  LimbaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.router.pop();
              }),
        );
      },
      viewModelBuilder: () => LimbaViewModel(),
    );
  }
}
