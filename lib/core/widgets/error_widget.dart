import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

/// A reusable widget to display an error message with an icon.
/// It supports internationalization and theme configuration.
class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;  // Error message to display

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    // Obtain the theme configuration
    final themeConfig = GetIt.I<AppTheme>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon indicating an error
            Icon(
              Icons.error_outline,
              size: 80,
              color: themeConfig.getConfigErrorColor(),  // Use the theme's error color
            ),
            const SizedBox(height: 16),

            // Display the error message passed to the widget
            Text(
              errorMessage,
              style: TextStyle(
                color: themeConfig.getDefaultTextColor(),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Provide a localized button to retry fetching data
            Text(
              AppLocalizations.of(context)!.error_loading_data,  // Translated text: "Please try again"
              style: TextStyle(
                color: themeConfig.getDefaultTextColor(),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
