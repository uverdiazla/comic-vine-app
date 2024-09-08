import 'package:comic_vine_app/features/comic_vine/domain/entities/comic_entity.dart';

/// ComicModel represents the data structure of a comic, specifically for handling JSON parsing
/// and other data-related tasks. It extends the basic domain ComicEntity.
class ComicModel extends ComicEntity {

  ComicModel({
    required super.id,
    required super.name,
    required super.issueNumber,
    required super.coverDate,
    required super.description,
    required super.imageUrl,
    required super.volumeId,
    required super.volumeName,
  });

  /// Factory constructor to parse JSON data and map it to a ComicEntity.
  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'] ?? 0,
      name: json['volume']['name'] ?? '',
      issueNumber: json['issue_number'] ?? '',
      coverDate: json['cover_date'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_urls']?['large_url'] ?? '',
      volumeId: json['volume']?['id'] ?? 0,
      volumeName: json['volume']?['name'] ?? '',
    );
  }
}
