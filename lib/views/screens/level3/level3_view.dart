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
import './level3_viewmodel.dart';

/// Storage dependencies
import 'package:realm/realm.dart';

class Level3View extends StatelessWidget {
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.router.replace(HomeView(initialIndex: 1));
            }, 
            child: Container(
              color: Colors.pink, 
              width: 100, 
              height: 100,
    
            )
          )
        ]
      ),
    );
  }
}