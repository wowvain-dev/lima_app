/// Auto Router Imports
import 'package:auto_route/annotations.dart';
import 'package:scoalafun/views/screens/home/home_view.dart';

/// Pages' Views

/// Contains the list of views that serve as routes
/// (used to generate `router.gr.dart`)
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route', 
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeView, initial: true),
  ])
class $AppRouter {}
