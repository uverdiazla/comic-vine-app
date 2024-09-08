import 'package:flutter/material.dart';

/// ISizeConfig defines the contract for handling screen dimensions and scaling
/// for responsive design across the app.
abstract class ISizeConfig {
  void init(BuildContext context);
  double getTextSize(double factor);
  double getWidthSize(double factor);
  double getHeightSize(double factor);
}
