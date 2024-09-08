import 'dart:convert';
import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:flutter/services.dart';


/// Implementation of ComicRepository using mock data stored in a JSON file.
class ComicRepositoryMock implements ComicRepository {
  @override
  Future<List<ComicModel>> fetchComics() async {
    final String response = await rootBundle.loadString('assets/mock_data/comics.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((comic) => ComicModel.fromJson(comic)).toList();
  }
}
