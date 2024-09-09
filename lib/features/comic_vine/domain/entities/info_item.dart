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

  /// Convert InfoItem to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  /// Convert Map to InfoItem
  factory InfoItem.fromMap(Map<String, dynamic> map) {
    return InfoItem(
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
