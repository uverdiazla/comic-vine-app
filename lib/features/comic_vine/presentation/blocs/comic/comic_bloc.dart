import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';

/// Bloc class to manage comic data fetching states
class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final ComicRepository repository;

  ComicBloc(this.repository) : super(ComicLoading()) {
    // Event to fetch comics list
    on<FetchComics>((event, emit) async {
      emit(ComicLoading());
      try {
        final comics = await repository.fetchComics();
        emit(ComicLoaded(comics));
      } catch (e) {
        emit(ComicError('Failed to load comics: $e'));
      }
    });

    // Event to fetch comic details
    on<FetchComicDetail>((event, emit) async {
      emit(ComicLoading());
      try {
        final comic = await repository.fetchComicDetail(event.comicId);
        emit(ComicDetailLoaded(comic));
      } catch (e) {
        emit(ComicError('Failed to load comic details: $e'));
      }
    });
  }
}
