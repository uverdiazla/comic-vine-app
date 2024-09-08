/// A model class to represent each item in the section.
class InfoItem {
  final String name;
  final String? description;
  final String? imageUrl;

  InfoItem({
    required this.name,
    this.description,
    this.imageUrl,
  });
}