/// Auto Router Imports
import 'package:auto_route/annotations.dart';
import 'package:lima/views/components/exercise_wrapper/exercise_wrapper.dart';

/// Pages
import 'package:lima/views/screens/home/home_view.dart';
import 'package:stacked/stacked.dart';

/// Screens
import '../views/screens/level1/level1_view.dart';
import '../views/screens/level1/materii/aritmetica1_view.dart';
import '../views/screens/level1/materii/geometrie1_view.dart';
import '../views/screens/level1/materii/romana1_view.dart';

/// Level 2
import '../views/screens/level2/level2_view.dart';

/// Level 3
import '../views/screens/level3/level3_view.dart';

/// Contains the list of views that serve as routes
/// (used to generate `router.gr.dart`)
@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  /// The initial home page.
  CustomRoute(
    page: HomeView,
    initial: true,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    durationInMilliseconds: 300,
  ),

  /// The three pages coresponding to the difficulty levels
  CustomRoute(
    page: Level1View,
    path: '/level1',
    children: [
      CustomRoute(
        path: 'aritmetica',
        page: Aritmetica1View,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
      ),
      CustomRoute(
          path: 'exercitii',
          page: ExerciseWrapper,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300),
      CustomRoute(
        path: 'geometrie',
        page: Geometrie1View,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
      ),
      CustomRoute(
        path: 'romana',
        page: Romana1View,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
      )
    ],
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 300,
  ),
  CustomRoute(
    page: Level2View,
    path: '/level2',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 300,
  ),
  CustomRoute(
    page: Level3View,
    path: '/level3',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 300,
  )
])
class $AppRouter {}
