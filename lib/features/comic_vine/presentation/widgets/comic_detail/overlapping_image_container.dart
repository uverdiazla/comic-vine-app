import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/contracts/i_size_config.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:get_it/get_it.dart';

class OverlappingImageContainer extends StatelessWidget {
  final String imageUrl;

  const OverlappingImageContainer({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = GetIt.I<IThemeConfig>();
    final responsiveConfig = GetIt.I<ISizeConfig>();

    return Container(
      color: themeConfig.getSecondaryBackgroundColor(),  // Same background color as the parent
      height: responsiveConfig.getHeightSize(24),  // Adjust the height of the title
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Comic image with fixed height
          Transform.translate(
            offset: Offset(0, responsiveConfig.getHeightSize(0.09)),
            child: Container(
              width: responsiveConfig.getWidthSize(33.5),  // Adjust the width of the image
              height: responsiveConfig.getHeightSize(22),  // Adjust the height of the image
              decoration: BoxDecoration(
                color: themeConfig.getPrimaryColor(),  // Match background color of the image container
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveConfig.getWidthSize(4.5),
                  vertical: responsiveConfig.getHeightSize(2),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeConfig.getPrimaryColor(),  // Ensure the same background color
                    borderRadius: BorderRadius.circular(10.0),  // Rounded corners for the internal container
                    border: Border.all(
                      color: Colors.transparent,  // Ensure no visible border
                      width: 0,  // No border width
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),  // Ensure the image corners are rounded
                    child: Image.network(
                      imageUrl,
                      height: responsiveConfig.getHeightSize(18.0),  // Adjust the height of the image
                      width: responsiveConfig.getWidthSize(24.5),  // Adjust the width of the image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
