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
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:stacked/stacked.dart' as _i16;

import '../views/components/exercitii/limba%20si%20comunicare/romana/recunoastere_litere.dart'
    as _i12;
import '../views/components/exercitii/limba%20si%20comunicare/romana/vocale_consoane.dart'
    as _i13;
import '../views/components/exercitii/matematica/aritmetica/formare.dart'
    as _i9;
import '../views/components/exercitii/matematica/aritmetica/fractii.dart'
    as _i7;
import '../views/components/exercitii/matematica/aritmetica/operatii.dart'
    as _i6;
import '../views/components/exercitii/matematica/aritmetica/ordine.dart' as _i8;
import '../views/screens/home/home_view.dart' as _i1;
import '../views/screens/level1/level1_view.dart' as _i2;
import '../views/screens/level1/materii/aritmetica1_view.dart' as _i5;
import '../views/screens/level1/materii/geometrie1_view.dart' as _i10;
import '../views/screens/level1/materii/romana1_view.dart' as _i11;
import '../views/screens/level2/level2_view.dart' as _i3;
import '../views/screens/level3/level3_view.dart' as _i4;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.slideLeftWithFade,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level1View.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.Level1View(),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level2View.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.Level2View(),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Level3View.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.Level3View(),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Aritmetica1View.name: (routeData) {
      final args = routeData.argsAs<Aritmetica1ViewArgs>(
          orElse: () => const Aritmetica1ViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.Aritmetica1View(key: args.key),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Operatii.name: (routeData) {
      final args = routeData.argsAs<OperatiiArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.Operatii(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Fractii.name: (routeData) {
      final args = routeData.argsAs<FractiiArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.Fractii(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Siruri.name: (routeData) {
      final args = routeData.argsAs<SiruriArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.OrdiniSiruri(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Formare.name: (routeData) {
      final args = routeData.argsAs<FormareArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.Formare(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Geometrie1View.name: (routeData) {
      final args = routeData.argsAs<Geometrie1ViewArgs>(
          orElse: () => const Geometrie1ViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.Geometrie1View(key: args.key),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Romana1View.name: (routeData) {
      final args = routeData.argsAs<Romana1ViewArgs>(
          orElse: () => const Romana1ViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.Romana1View(key: args.key),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ExercitiuLitere.name: (routeData) {
      final args = routeData.argsAs<ExercitiuLitereArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.ExercitiuLitere(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ExercitiuVocale.name: (routeData) {
      final args = routeData.argsAs<ExercitiuVocaleArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.ExercitiuVocale(
          key: args.key,
          level: args.level,
        ),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          HomeView.name,
          path: '/',
        ),
        _i14.RouteConfig(
          Level1View.name,
          path: '/level1',
          children: [
            _i14.RouteConfig(
              Aritmetica1View.name,
              path: 'aritmetica',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Operatii.name,
              path: 'operatii',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Fractii.name,
              path: 'fractii',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Siruri.name,
              path: 'siruri',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Formare.name,
              path: 'formare',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Geometrie1View.name,
              path: 'geometrie',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              Romana1View.name,
              path: 'romana',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              ExercitiuLitere.name,
              path: 'litere',
              parent: Level1View.name,
            ),
            _i14.RouteConfig(
              ExercitiuVocale.name,
              path: 'vocale',
              parent: Level1View.name,
            ),
          ],
        ),
        _i14.RouteConfig(
          Level2View.name,
          path: '/level2',
        ),
        _i14.RouteConfig(
          Level3View.name,
          path: '/level3',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i14.PageRouteInfo<HomeViewArgs> {
  HomeView({
    _i15.Key? key,
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

  final _i15.Key? key;

  final int? initialIndex;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i2.Level1View]
class Level1View extends _i14.PageRouteInfo<void> {
  const Level1View({List<_i14.PageRouteInfo>? children})
      : super(
          Level1View.name,
          path: '/level1',
          initialChildren: children,
        );

  static const String name = 'Level1View';
}

/// generated route for
/// [_i3.Level2View]
class Level2View extends _i14.PageRouteInfo<void> {
  const Level2View()
      : super(
          Level2View.name,
          path: '/level2',
        );

  static const String name = 'Level2View';
}

/// generated route for
/// [_i4.Level3View]
class Level3View extends _i14.PageRouteInfo<void> {
  const Level3View()
      : super(
          Level3View.name,
          path: '/level3',
        );

  static const String name = 'Level3View';
}

/// generated route for
/// [_i5.Aritmetica1View]
class Aritmetica1View extends _i14.PageRouteInfo<Aritmetica1ViewArgs> {
  Aritmetica1View({_i15.Key? key})
      : super(
          Aritmetica1View.name,
          path: 'aritmetica',
          args: Aritmetica1ViewArgs(key: key),
        );

  static const String name = 'Aritmetica1View';
}

class Aritmetica1ViewArgs {
  const Aritmetica1ViewArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'Aritmetica1ViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.Operatii]
class Operatii extends _i14.PageRouteInfo<OperatiiArgs> {
  Operatii({
    _i15.Key? key,
    required int level,
  }) : super(
          Operatii.name,
          path: 'operatii',
          args: OperatiiArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'Operatii';
}

class OperatiiArgs {
  const OperatiiArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'OperatiiArgs{key: $key, level: $level}';
  }
}

/// generated route for
/// [_i7.Fractii]
class Fractii extends _i14.PageRouteInfo<FractiiArgs> {
  Fractii({
    _i15.Key? key,
    required int level,
  }) : super(
          Fractii.name,
          path: 'fractii',
          args: FractiiArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'Fractii';
}

class FractiiArgs {
  const FractiiArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'FractiiArgs{key: $key, level: $level}';
  }
}

/// generated route for
/// [_i8.OrdiniSiruri]
class Siruri extends _i14.PageRouteInfo<SiruriArgs> {
  Siruri({
    _i15.Key? key,
    required int level,
  }) : super(
          Siruri.name,
          path: 'siruri',
          args: SiruriArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'Siruri';
}

class SiruriArgs {
  const SiruriArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'SiruriArgs{key: $key, level: $level}';
  }
}

/// generated route for
/// [_i9.Formare]
class Formare extends _i14.PageRouteInfo<FormareArgs> {
  Formare({
    _i15.Key? key,
    required int level,
  }) : super(
          Formare.name,
          path: 'formare',
          args: FormareArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'Formare';
}

class FormareArgs {
  const FormareArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'FormareArgs{key: $key, level: $level}';
  }
}

/// generated route for
/// [_i10.Geometrie1View]
class Geometrie1View extends _i14.PageRouteInfo<Geometrie1ViewArgs> {
  Geometrie1View({_i15.Key? key})
      : super(
          Geometrie1View.name,
          path: 'geometrie',
          args: Geometrie1ViewArgs(key: key),
        );

  static const String name = 'Geometrie1View';
}

class Geometrie1ViewArgs {
  const Geometrie1ViewArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'Geometrie1ViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.Romana1View]
class Romana1View extends _i14.PageRouteInfo<Romana1ViewArgs> {
  Romana1View({_i15.Key? key})
      : super(
          Romana1View.name,
          path: 'romana',
          args: Romana1ViewArgs(key: key),
        );

  static const String name = 'Romana1View';
}

class Romana1ViewArgs {
  const Romana1ViewArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'Romana1ViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.ExercitiuLitere]
class ExercitiuLitere extends _i14.PageRouteInfo<ExercitiuLitereArgs> {
  ExercitiuLitere({
    _i15.Key? key,
    required int level,
  }) : super(
          ExercitiuLitere.name,
          path: 'litere',
          args: ExercitiuLitereArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'ExercitiuLitere';
}

class ExercitiuLitereArgs {
  const ExercitiuLitereArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'ExercitiuLitereArgs{key: $key, level: $level}';
  }
}

/// generated route for
/// [_i13.ExercitiuVocale]
class ExercitiuVocale extends _i14.PageRouteInfo<ExercitiuVocaleArgs> {
  ExercitiuVocale({
    _i15.Key? key,
    required int level,
  }) : super(
          ExercitiuVocale.name,
          path: 'vocale',
          args: ExercitiuVocaleArgs(
            key: key,
            level: level,
          ),
        );

  static const String name = 'ExercitiuVocale';
}

class ExercitiuVocaleArgs {
  const ExercitiuVocaleArgs({
    this.key,
    required this.level,
  });

  final _i15.Key? key;

  final int level;

  @override
  String toString() {
    return 'ExercitiuVocaleArgs{key: $key, level: $level}';
  }
}
