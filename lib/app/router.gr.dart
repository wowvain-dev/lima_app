// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:stacked/stacked.dart' as _i7;

import '../views/screens/home/home_view.dart' as _i1;
import '../views/screens/level1/level1_view.dart' as _i2;
import '../views/screens/level2/level2_view.dart' as _i3;
import '../views/screens/level3/level3_view.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
        transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level1View.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.Level1View(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level2View.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.Level2View(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level3View.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.Level3View(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeView.name,
          path: '/',
        ),
        _i5.RouteConfig(
          Level1View.name,
          path: '/level1-view',
        ),
        _i5.RouteConfig(
          Level2View.name,
          path: '/level2-view',
        ),
        _i5.RouteConfig(
          Level3View.name,
          path: '/level3-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i5.PageRouteInfo<HomeViewArgs> {
  HomeView({
    _i6.Key? key,
    int? initialIndex,
  }) : super(
          HomeView.name,
          path: '/',
          args: HomeViewArgs(
            key: key,
            initialIndex: initialIndex,
          ),
        );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({
    this.key,
    this.initialIndex,
  });

  final _i6.Key? key;

  final int? initialIndex;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i2.Level1View]
class Level1View extends _i5.PageRouteInfo<void> {
  const Level1View()
      : super(
          Level1View.name,
          path: '/level1-view',
        );

  static const String name = 'Level1View';
}

/// generated route for
/// [_i3.Level2View]
class Level2View extends _i5.PageRouteInfo<void> {
  const Level2View()
      : super(
          Level2View.name,
          path: '/level2-view',
        );

  static const String name = 'Level2View';
}

/// generated route for
/// [_i4.Level3View]
class Level3View extends _i5.PageRouteInfo<void> {
  const Level3View()
      : super(
          Level3View.name,
          path: '/level3-view',
        );

  static const String name = 'Level3View';
}
