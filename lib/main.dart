/// Flutter
import 'package:flutter/material.dart';
import 'package:scoalafun/app/locator.dart';
import 'package:scoalafun/app/router.gr.dart';
import 'package:scoalafun/services/layout_manager.dart';

/// Router
import 'app/router.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
        title: 'ScoalaFun',
        theme: ThemeData(
            primaryColor: Colors.amber.shade300,
            textTheme: const TextTheme(
              displayLarge:
                  TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontSize: 24.0),
              bodyMedium: TextStyle(fontSize: 14.0),
            )),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(), 
        );
  }
}
