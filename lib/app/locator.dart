/// Inversion of Control dependency

import 'package:get_it/get_it.dart';
import 'package:lima/models/classes/difficulty_manager.dart';
import 'package:lima/models/classes/sidemenu_manager.dart';
import 'package:lima/models/classes/storage_manager.dart';

import '../models/classes/header_manager.dart';


final l = GetIt.instance;

/// Setting up the objects accessible from
/// anywhere in the app using IoC.
void setup() {
  HeaderManager headerManager = HeaderManager.init();
  l.registerSingleton<HeaderManager>(headerManager);

  SideMenuManager sideMenuManager = SideMenuManager();
  l.registerSingleton<SideMenuManager>(sideMenuManager);

  DifficultyManager difficultyManager = DifficultyManager();
  l.registerSingleton<DifficultyManager>(difficultyManager);

  StorageManager storageManager = StorageManager();
  l.registerSingleton<StorageManager>(storageManager);
}
