import 'package:comic_vine_app/core/widgets/custom_divider.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/info_item_model.dart';
import 'package:flutter/material.dart';

/// A reusable widget that displays a section with a title and a list of items.
/// Each item contains an optional image, name, and description.
class InfoSectionList extends StatelessWidget {
  final String sectionTitle;
  final List<InfoItem> items;

  const InfoSectionList({
    super.key,
    required this.sectionTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: Theme.of(context).textTheme.bodyLarge,  // Apply bodyLarge style
          ),
          CustomDivider(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            opacity: 0.6,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Avoids scrolling inside the grid
            shrinkWrap: true, // Allows GridView to take only the necessary height
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              childAspectRatio: 3.5, // Adjust the height of each item
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Row(
                children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                          ? Image.network(
                        item.imageUrl!,
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 40.0,
                        height: 40.0,
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade700,
                          size: 24.0,  // Icon size
                        ),
                      ),
                    ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if(item.description != null)
                          const SizedBox(height: 7.0),
                        if (item.description != null)
                          Text(
                            item.description!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }
}