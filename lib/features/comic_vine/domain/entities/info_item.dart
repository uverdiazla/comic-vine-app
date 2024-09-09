/// A domain model class to represent each item in a section.
/// It can be a creator, character, or any other entity in the comic-related domain.
class InfoItem {
  final String name;             // Name of the entity (creator, character, etc.)
  final String? description;     // Optional description (role, summary, etc.)
  final String? imageUrl;        // Optional image URL representing the entity

  InfoItem({
    required this.name,
    this.description,
    this.imageUrl,
  });
}
