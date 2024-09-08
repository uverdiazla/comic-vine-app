import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final ComicRepository repository;

  ComicBloc(this.repository) : super(ComicLoading()) {
    on<FetchComics>((event, emit) async {
      emit(ComicLoading());
      try {
        final comics = await repository.fetchComics();
        emit(ComicLoaded(comics));
      } catch (e) {
        emit(ComicError(e.toString()));
      }
    });
  }
}
