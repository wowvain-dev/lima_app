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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../views/screens/home/home_view.dart' as _i1;
import '../views/screens/limba/limba_view.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(key: args.key),
      );
    },
    LimbaView.name: (routeData) {
      final args =
          routeData.argsAs<LimbaViewArgs>(orElse: () => const LimbaViewArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LimbaView(key: args.key),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeView.name,
          path: '/',
        ),
        _i3.RouteConfig(
          LimbaView.name,
          path: '/limba-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i3.PageRouteInfo<HomeViewArgs> {
  HomeView({_i4.Key? key})
      : super(
          HomeView.name,
          path: '/',
          args: HomeViewArgs(key: key),
        );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LimbaView]
class LimbaView extends _i3.PageRouteInfo<LimbaViewArgs> {
  LimbaView({_i4.Key? key})
      : super(
          LimbaView.name,
          path: '/limba-view',
          args: LimbaViewArgs(key: key),
        );

  static const String name = 'LimbaView';
}

class LimbaViewArgs {
  const LimbaViewArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'LimbaViewArgs{key: $key}';
  }
}
