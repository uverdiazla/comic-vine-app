import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';

/// A custom divider with optional padding and customizable color and thickness.
class CustomDivider extends StatelessWidget {
  final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;  // Obtain theme configuration

  final EdgeInsetsGeometry? padding;  // Optional padding, nullable

  final double opacity;  // Opacity value for the divider color

  CustomDivider({super.key, this.padding, this.opacity = 0.3});  // Constructor with optional padding

  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(
      color: themeConfig.getSubtitleSectionColor().withOpacity(opacity),  // Custom color with opacity
      height: 3,
      thickness: 1.5,  // Custom thickness
    );

    // Apply padding only if provided, otherwise return the divider without padding
    if (padding != null) {
      return Padding(
        padding: padding!,  // Apply the passed padding
        child: divider,
      );
    }
    return divider;  // Return without padding if no padding is provided
  }
}
