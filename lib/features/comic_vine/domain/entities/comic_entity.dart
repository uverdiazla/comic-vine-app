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
  });
}
