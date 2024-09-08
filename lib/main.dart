import 'package:comic_vine_app/core/contracts/i_size_config.dart';
import 'package:comic_vine_app/core/responsive/size_config.dart';
import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/app/app_root.dart';
import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/data/repositories/comic_repository_mock.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/core/contracts/i_date_formatter.dart';
import 'package:comic_vine_app/core/utils/date_formatter.dart';

final GetIt locator = GetIt.instance;

/// Sets up the service locator and registers the necessary dependencies.
void setupLocator() {
  // Register the mock repository
  locator.registerLazySingleton<ComicRepository>(() => ComicRepositoryMock());

  // Register ComicBloc using the injected repository
  locator.registerFactory(() => ComicBloc(locator<ComicRepository>()));

  // Register DateFormatter for date formatting
  locator.registerLazySingleton<IDateFormatter>(() => DateFormatter());

  // Register the theme configuration
  locator.registerLazySingleton<IThemeConfig>(() => AppTheme());

  // Register the responsive size configuration
  locator.registerLazySingleton<ISizeConfig>(() => SizeConfig());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const AppRoot());
}
