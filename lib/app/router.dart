/// Auto Router Imports
import 'package:auto_route/annotations.dart';

/// Pages
import 'package:lima/views/screens/home/home_view.dart';
import 'package:stacked/stacked.dart';
import '../views/screens/level1/level1_view.dart';
import '../views/screens/level2/level2_view.dart';
import '../views/screens/level3/level3_view.dart';

/// Contains the list of views that serve as routes
/// (used to generate `router.gr.dart`)
@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  /// The initial home page.
  AutoRoute(page: HomeView, initial: true),
  
  /// The three pages coresponding to the difficulty levels
  CustomRoute(page: Level1View, 
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 200,
  ),
  AutoRoute(page: Level2View), 
  AutoRoute(page: Level3View) 
])
class $AppRouter {}
