class ComicModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  ComicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Factory constructor to parse JSON data
  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
