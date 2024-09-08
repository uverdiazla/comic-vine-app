import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';

/// Implementation of the app theme configuration.
/// This sets up primary and accent colors, text styles, etc.
class AppTheme implements IThemeConfig {
  // Define the colors used across the app
  static const Color _primaryColor = Color(0xffefefef);
  static const Color _secondaryBackgroundColor = Color(0xFF646464);    // Creator text color
  static const Color _appBarColor = Color(0xFF232828);
  static const Color _accentColor = Colors.orange;
  static const Color _titleSection = Color(0xff23854f);      // Title color
  static const Color _subtitleSection = Color(0xFF8E8E8E);   // Subtitle color
  static const Color _defaultTextColor = Color(0xFF121212); // Default text color

  @override
  ThemeData getTheme() {
    return ThemeData(
      primaryColor: _primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
      ),
      scaffoldBackgroundColor: _primaryColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _accentColor,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }
  @override
  Color getPrimaryColor() {
    return _primaryColor;
  }

  @override
  Color getAccentColor() {
    return _accentColor;
  }

  @override
  Color getSecondaryBackgroundColor() {
    return _secondaryBackgroundColor;
  }

  @override
  Color getAppBarColor() {
    return _appBarColor;
  }

  @override
  Color getTitleSectionColor() {
    return _titleSection;
  }

  @override
  Color getSubtitleSectionColor() {
    return _subtitleSection;
  }

  @override
  Color getDefaultTextColor() {
    return _defaultTextColor;
  }
}
