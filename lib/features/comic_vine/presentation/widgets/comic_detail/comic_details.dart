import 'package:comic_vine_app/core/widgets/info_section_list.dart';
import 'package:comic_vine_app/core/widgets/responsive_spacer.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/info_item_model.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_description.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_detail_title.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/overlapping_image_container.dart';
import 'package:flutter/material.dart';

/// A reusable widget that displays the detailed view of a comic,
/// including its image, title, issue number, and description.
/// It also shows sections for creators and characters.
class ComicDetailCard extends StatelessWidget {
  final String imageUrl;      // URL of the comic image
  final String title;         // Title of the comic
  final String issueNumber;   // Issue number of the comic
  final String description;   // Description of the comic

  const ComicDetailCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.issueNumber,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data for creators and characters to showcase
    final List<InfoItem> creators = _getCreatorsData();
    final List<InfoItem> characters = _getCharactersData();
    final List<InfoItem> teams = _getTeamsData();

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the comic title and issue number with a background
          ComicDetailTitle(
            title: title,
            issueNumber: issueNumber,
          ),

          // Displays the comic image with an overlapping effect
          OverlappingImageContainer(
            imageUrl: imageUrl,
          ),

          // Responsive spacer to provide space between elements
          ResponsiveSpacer(height: 2.5),

          // Displays the description of the comic
          ComicDescription(description: description),

          ResponsiveSpacer(height: 2.5),

          // Section displaying the creators of the comic
          InfoSectionList(
            sectionTitle: 'Creators',
            items: creators,
          ),

          // Section displaying the characters in the comic
          InfoSectionList(
            sectionTitle: 'Characters',
            items: characters,
          ),

          // Section teams
          InfoSectionList(
            sectionTitle: 'Teams',
            items: teams,
          ),

          // Section Locations
          const InfoSectionList(
            sectionTitle: 'Locations',
            items: [],
          ),

          // Section Concepts
          const InfoSectionList(
            sectionTitle: 'Concepts',
            items: [],
          ),
        ],
      ),
    );
  }

  /// Returns dummy data for the creators of the comic.
  List<InfoItem> _getCreatorsData() {
    return [
      InfoItem(name: 'Anthony Oliveira', description: 'Writer', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
      InfoItem(name: 'Ariana Maher', description: 'Letterer', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
      InfoItem(name: 'Carlos Lopez', description: 'Colorist', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
      InfoItem(name: 'Sarah Brunstad', description: 'Editor', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
    ];
  }

  /// Returns dummy data for the characters in the comic.
  List<InfoItem> _getCharactersData() {
    return [
      InfoItem(name: 'Captain America', imageUrl: ''),
      InfoItem(name: 'Iron Man', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
      InfoItem(name: 'Thor', imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d'),
    ];
  }

  /// Returns dummy data for the teams in the comic.
  List<InfoItem> _getTeamsData() {
    return [
      InfoItem(name: 'Avengers', imageUrl: ''),
    ];
  }

}
