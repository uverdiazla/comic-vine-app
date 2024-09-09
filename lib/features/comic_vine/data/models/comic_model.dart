import 'dart:convert';

import 'package:comic_vine_app/features/comic_vine/domain/entities/comic_entity.dart';
import 'package:comic_vine_app/features/comic_vine/domain/entities/info_item.dart';

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
    super.creators,
    super.characters,
    super.teams,
    super.locations,
    super.concepts,
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

  /// Convert Map to ComicEntity
  factory ComicModel.fromMap(Map<String, dynamic> map) {
    return ComicModel(
      id: map['id'],
      name: map['name'],
      issueNumber: map['issueNumber'],
      coverDate: map['coverDate'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      volumeId: map['volumeId'],
      volumeName: map['volumeName'],
      creators: (jsonDecode(map['creators']) as List<dynamic>)
          .map((e) => InfoItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      characters: (jsonDecode(map['characters']) as List<dynamic>)
          .map((e) => InfoItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      teams: (jsonDecode(map['teams']) as List<dynamic>)
          .map((e) => InfoItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      locations: (jsonDecode(map['locations']) as List<dynamic>)
          .map((e) => InfoItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      concepts: (jsonDecode(map['concepts']) as List<dynamic>)
          .map((e) => InfoItem.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
