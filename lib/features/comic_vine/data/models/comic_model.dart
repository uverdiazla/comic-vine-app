/// ComicModel represents the data structure of a comic in the domain layer.
/// It handles null values gracefully and provides default values where needed.
class ComicModel {
  final int id;
  final String name;
  final String issueNumber;
  final String coverDate;
  final String description;
  final String imageUrl;
  final int volumeId;
  final String volumeName;

  /// Constructor to create a ComicModel instance.
  ComicModel({
    required this.id,
    required this.name,
    required this.issueNumber,
    required this.coverDate,
    required this.description,
    required this.imageUrl,
    required this.volumeId,
    required this.volumeName,
  });

  /// Factory constructor to parse JSON data and handle null values.
  /// It provides default values like 'Unknown' for strings and 'No description available' for description field.
  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'] ?? 0,  // Default to 0 if null
      name: json['volume']['name'] ?? '',  // Default to 'Unknown' if null
      issueNumber: json['issue_number'] ?? '',  // Handle possible nulls
      coverDate: json['cover_date'] ?? '',  // Handle nulls
      description: json['description'] ?? '',  // Provide default description if null
      imageUrl: json['image_urls']?['large_url'] ?? '',  // Handle possible null in nested field
      volumeId: json['volume']?['id'] ?? 0,  // Handle nulls in nested field
      volumeName: json['volume']?['name'] ?? '',  // Handle nulls in nested field
    );
  }
}
