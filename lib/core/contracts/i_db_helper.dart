import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';

abstract class IDBHelper {
  Future<void> initDB();
  Future<void> insertComic(ComicModel comic);
  Future<ComicModel?> getComic(int id);
  Future<List<ComicModel>> getAllComics();
}
