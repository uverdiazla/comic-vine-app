import 'package:comic_vine_app/core/widgets/info_section_list.dart';
import 'package:comic_vine_app/core/widgets/responsive_spacer.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_description.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_detail_title.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/overlapping_image_container.dart';
import 'package:flutter/material.dart';

/// A reusable widget that displays the detailed view of a comic,
/// including its image, title, issue number, and description.
/// It also shows sections for creators and characters.
class ComicDetailCard extends StatelessWidget {
  final ComicModel comic;

  const ComicDetailCard({
    super.key,
    required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the comic title and issue number with a background
          ComicDetailTitle(
            title: comic.name,
            issueNumber: comic.issueNumber,
          ),

          // Displays the comic image with an overlapping effect
          OverlappingImageContainer(
            imageUrl: comic.imageUrl,
          ),

          // Responsive spacer to provide space between elements
          ResponsiveSpacer(height: 2.5),

          // Displays the description of the comic
          ComicDescription(description: comic.description),

          ResponsiveSpacer(height: 2.5),

          // Section displaying the creators of the comic
          InfoSectionList(
            sectionTitle: 'Creators',
            items: comic.creators ?? [],
          ),

          // Section displaying the characters in the comic
          InfoSectionList(
            sectionTitle: 'Characters',
            items: comic.characters ?? [],
          ),

          // Section teams
          InfoSectionList(
            sectionTitle: 'Teams',
            items: comic.teams ?? [],
          ),

          // Section Locations
          InfoSectionList(
            sectionTitle: 'Locations',
            items: comic.locations ?? [],
          ),

          // Section Concepts
          InfoSectionList(
            sectionTitle: 'Concepts',
            items: comic.concepts ?? [],
          ),
        ],
      ),
    );
  }
}
