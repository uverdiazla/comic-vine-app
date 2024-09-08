import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/core/contracts/i_size_config.dart';

/// A reusable widget that adds responsive spacing (vertical or horizontal)
/// based on the screen size. The spacing can be customized using height or width.
class ResponsiveSpacer extends StatelessWidget {
  final double? height;  // Optional height for vertical spacing
  final double? width;   // Optional width for horizontal spacing

  // Obtain the responsive configuration instance
  final ISizeConfig responsiveConfig = GetIt.I<ISizeConfig>();

  ResponsiveSpacer({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    // If height is provided, use it to create vertical spacing
    if (height != null) {
      return SizedBox(
        height: responsiveConfig.getHeightSize(height!),  // Calculate responsive height
      );
    }

    // If width is provided, use it to create horizontal spacing
    if (width != null) {
      return SizedBox(
        width: responsiveConfig.getWidthSize(width!),  // Calculate responsive width
      );
    }

    // If neither height nor width is provided, return a default small spacer
    return const SizedBox.shrink();
  }
}
