import 'dart:convert';

import 'package:comic_vine_app/features/comic_vine/domain/entities/info_item.dart';

/// ComicEntity represents the core business entity for a comic.
/// This entity contains only the essential data relevant to the domain layer.
class ComicEntity {
  final int id;
  final String name;
  final String issueNumber;
  final String coverDate;
  final String description;
  final String imageUrl;
  final int volumeId;
  final String volumeName;
  final List<InfoItem>? creators;
  final List<InfoItem>? characters;
  final List<InfoItem>? teams;
  final List<InfoItem>? locations;
  final List<InfoItem>? concepts;

  /// Constructor to create a ComicEntity instance.
  ComicEntity({
    required this.id,
    required this.name,
    required this.issueNumber,
    required this.coverDate,
    required this.description,
    required this.imageUrl,
    required this.volumeId,
    required this.volumeName,
    this.creators,
    this.characters,
    this.teams,
    this.locations,
    this.concepts,
  });

  /// Convert ComicEntity to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'issueNumber': issueNumber,
      'coverDate': coverDate,
      'description': description,
      'imageUrl': imageUrl,
      'volumeId': volumeId,
      'volumeName': volumeName,
      'creators': jsonEncode(creators?.map((e) => e.toMap()).toList() ?? []),
      'characters': jsonEncode(characters?.map((e) => e.toMap()).toList() ?? []),
      'teams': jsonEncode(teams?.map((e) => e.toMap()).toList() ?? []),
      'locations': jsonEncode(locations?.map((e) => e.toMap()).toList() ?? []),
      'concepts': jsonEncode(concepts?.map((e) => e.toMap()).toList() ?? []),
    };
  }

  /// Convert Map to ComicEntity
  factory ComicEntity.fromMap(Map<String, dynamic> map) {
    return ComicEntity(
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
