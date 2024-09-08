import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ComicDescription extends StatelessWidget {
  final String description;

  const ComicDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {

    final themeConfig = GetIt.I<IThemeConfig>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 17.5,
          fontStyle: FontStyle.italic,
          height: 1.6,
          color: themeConfig.getDefaultTextColor(),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
