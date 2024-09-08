import 'package:flutter/widgets.dart';
import 'package:comic_vine_app/core/contracts/i_size_config.dart';

/// SizeConfig class handles screen dimensions and scaling factors
/// for responsive design, making sure UI elements adapt to various screen sizes.
class SizeConfig implements ISizeConfig {
  // Screen dimensions and scaling factors
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  @override
  void init(BuildContext context) {
    // Retrieve media query data and calculate screen dimensions
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100; // 1% of screen width
    blockSizeVertical = screenHeight / 100;  // 1% of screen height
  }

  @override
  double getTextSize(double factor) {
    // Return text size based on screen height factor
    return blockSizeVertical * factor;
  }

  @override
  double getWidthSize(double factor) {
    // Return image size based on screen width factor
    return blockSizeHorizontal * factor;
  }

  @override
  double getHeightSize(double factor) {
    // Return height size based on screen height factor
    return blockSizeVertical * factor;
  }
}
