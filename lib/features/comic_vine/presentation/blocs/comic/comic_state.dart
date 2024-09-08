import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';

abstract class ComicState {}

class ComicLoading extends ComicState {}

class ComicLoaded extends ComicState {
  final List<ComicModel> comics;
  ComicLoaded(this.comics);
}

class ComicError extends ComicState {
  final String message;
  ComicError(this.message);
}
