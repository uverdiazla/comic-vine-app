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
}
