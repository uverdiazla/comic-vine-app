import 'package:comic_vine_app/core/contracts/i_size_config.dart';
import 'package:comic_vine_app/core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/core/contracts/i_date_formatter.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ComicTile extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String issueNumber;
  final DateTime releaseDate;

  final IDateFormatter dateFormatter = GetIt.I<IDateFormatter>();
  final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;  // Obtain theme configuration
  final responsiveConfig = GetIt.I<ISizeConfig>();  // Obtain responsive configuration

  ComicTile({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.issueNumber,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the comic detail page when the tile is tapped
        GoRouter.of(context).push('/comic/$id');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),  // Uniform padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,  // Align text to the left
          children: [
            // Display comic image with full width
            Image.network(imageUrl, height: responsiveConfig.getHeightSize(70), width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: responsiveConfig.getHeightSize(2.5)),
            Text(
              '$title #$issueNumber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: themeConfig.getDefaultTextColor(),  // Use theme for title color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: responsiveConfig.getHeightSize(0.6)),
            Text(
              dateFormatter.formatDateWithMonthName(releaseDate),  // Using the injected date formatter for the release date
              style: TextStyle(
                fontSize: 16,
                color: themeConfig.getSubtitleSectionColor(),  // Use theme for default text color
              ),
            ),
            SizedBox(height: responsiveConfig.getHeightSize(1)),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}
