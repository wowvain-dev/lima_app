/// Flutter
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lima/app/locator.dart';
import 'package:lima/app/router.gr.dart';
import 'package:motion/motion.dart';


/// Services

/// Themes
import 'themes/theme.dart';

/// Router
import 'app/router.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    
  await Motion.instance.initialize();

  Motion.instance.setUpdateInterval(60.fps);

  try {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        setWindowTitle('Lima - Culegere Interactivă');
        setWindowMinSize(const Size(1080, 500));
      }
  } catch(e) {
    
  }
    
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lima - Culegere Interactiva',
      theme: Themes().customLightTheme(),
      darkTheme: Themes().customDarkTheme(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
