import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';

/// Implementation of the app theme configuration.
/// This sets up primary and accent colors, text styles, etc.
class AppTheme implements IThemeConfig {
  static const Color _primaryColor = Color(0xffefefef);
  static const Color _secondaryBackgroundColor = Color(0xFF646464);
  static const Color _appBarColor = Color(0xFF232828);
  static const Color _accentColor = Colors.orange;
  static const Color _titleSection = Color(0xff23854f);
  static const Color _subtitleSection = Color(0xFF8E8E8E);
  static const Color _defaultTextColor = Color(0xFF121212);
  static const Color _configErrorColor = Color(0xFFD32F2F);

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
        bodyLarge: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w900,),
        bodyMedium: TextStyle(color: _titleSection, fontSize: 14, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(color: _subtitleSection, fontSize: 12, fontWeight: FontWeight.normal),
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

  @override
  Color getConfigErrorColor() {
    return _configErrorColor;
  }
}
