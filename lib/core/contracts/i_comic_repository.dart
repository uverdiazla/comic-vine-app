import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';

/// ComicRepository defines the contract for fetching comics data,
/// allowing for different implementations (mock data, API, etc.).
abstract class ComicRepository {
  Future<List<ComicModel>> fetchComics();
}
