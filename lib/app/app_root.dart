import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:comic_vine_app/app/routes/app_routes.dart';
import 'package:comic_vine_app/core/responsive/size_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The root of the application, responsible for initializing
/// theme, routes, and responsive settings.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize GoRouter for navigation
    final GoRouter router = AppRoutes.router;

    // LayoutBuilder allows us to initialize responsive design based on screen size
    return LayoutBuilder(
      builder: (context, constraints) {
        // Initialize responsive settings (e.g., text size, layout size)
        SizeConfig().init(context);

        // Define the main structure of the app
        return MaterialApp.router(
          title: 'Comic Vine App',
          theme: AppTheme().getTheme(), // Apply the custom theme
          routerConfig: router, // Use GoRouter for route configuration

          // Localizations settings for multiple languages
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // Inglés
            Locale('es', ''), // Español
          ],
          locale: const Locale('en'),  // Idioma por defecto, pero puede cambiar en tiempo de ejecución
        );
      },
    );
  }
}
