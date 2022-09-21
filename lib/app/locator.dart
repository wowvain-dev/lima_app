/// Inversion of Control dependency
import 'package:get_it/get_it.dart';
import 'package:scoalafun/services/layout_manager.dart';

final l = GetIt.instance;

/// Setting up the objects accessible from
/// anywhere in the app using IoC.
void setup() {
  LayoutManager layoutManager = LayoutManager();
  l.registerSingleton<LayoutManager>(layoutManager);
}
