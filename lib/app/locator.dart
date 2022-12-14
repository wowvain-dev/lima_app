/// Inversion of Control dependency
import 'package:get_it/get_it.dart';
import 'package:lima/models/difficulty_manager.dart';
import 'package:lima/models/sidemenu_manager.dart';


final l = GetIt.instance;

/// Setting up the objects accessible from
/// anywhere in the app using IoC.
void setup() {
  SideMenuManager sideMenuManager = SideMenuManager();
  l.registerSingleton<SideMenuManager>(sideMenuManager);

  DifficultyManager difficultyManager = DifficultyManager();
  l.registerSingleton<DifficultyManager>(difficultyManager);
}
