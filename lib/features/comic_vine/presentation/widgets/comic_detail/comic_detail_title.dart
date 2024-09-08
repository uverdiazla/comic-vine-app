import 'package:comic_vine_app/core/contracts/i_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ComicDetailTitle extends StatelessWidget {
  final String title;
  final String issueNumber;

  const ComicDetailTitle({
    super.key,
    required this.title,
    required this.issueNumber,
  });

  @override
  Widget build(BuildContext context) {
    
    final responsiveConfig = GetIt.I<ISizeConfig>();
    
    return Container(
      color: const Color(0xFF1A1D1D),  // Dark blue background color
      padding: EdgeInsets.symmetric(vertical:responsiveConfig.getHeightSize(2.5), horizontal: responsiveConfig.getWidthSize(4) ),  // Add padding inside the container
      height: responsiveConfig.getHeightSize(13),  // Adjust the height of the title container
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,  // Main title text
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,  // Larger font size for the title
                      color: Colors.white,  // White color for title
                    ),
                  ),
                  TextSpan(
                    text: ' #$issueNumber',  // Issue number text
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,  // Smaller font size for the issue number
                      color: Colors.grey,  // Grey color for the issue number
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,  // Ensure the text doesn't overflow
            ),
          ),
        ],
      ),
    );
  }
}
