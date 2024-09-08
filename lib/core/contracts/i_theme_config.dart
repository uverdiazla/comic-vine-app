import 'package:flutter/material.dart';

/// IThemeConfig defines the contract for managing the app's theme,
/// including colors and any specific design elements.
abstract class IThemeConfig {
  ThemeData getTheme();
  Color getPrimaryColor();
  Color getAccentColor();
  Color getSecondaryBackgroundColor();
  Color getAppBarColor();
  Color getTitleSectionColor();
  Color getSubtitleSectionColor();
  Color getDefaultTextColor();
}
