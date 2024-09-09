import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/core/contracts/i_comic_repository.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';

/// Bloc class responsible for managing comic data fetching and state transitions.
class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final IComicRepository repository; // Repository to fetch comic data from API or other sources
  int currentPage = 1; // Tracks the current page for pagination, starts from 1
  List<ComicModel> allComics = []; // Accumulates all comics fetched so far

  /// Constructor that sets the initial state and defines event handlers.
  ComicBloc(this.repository) : super(ComicLoading()) {

    // Handles the FetchComics event to load the list of comics
    on<FetchComics>((event, emit) async {
      try {
        // If comics are already loaded, emit ComicLoadingMore to indicate more loading
        if (allComics.isNotEmpty) {
          emit(ComicLoadingMore(allComics));
        } else {
          // Otherwise, emit ComicLoading for the first page load
          emit(ComicLoading());
        }

        // Fetch the next page of comics using the repository
        final comics = await repository.fetchComics(currentPage);

        // Increment the page for the next fetch (pagination control)
        currentPage++;

        // Add the newly fetched comics to the existing list
        allComics.addAll(comics);

        // Emit the updated list of comics
        emit(ComicLoaded(allComics));
      } catch (e) {
        // In case of any error, emit ComicError with a message
        emit(ComicError('Failed to load comics: $e'));
      }
    });

    // Handles the FetchComicDetail event to load details of a specific comic by its ID
    on<FetchComicDetail>((event, emit) async {
      emit(ComicLoading());  // Emit loading state while fetching comic details
      try {
        // Fetch from the repository (which handles cache and API)
        final comic = await repository.fetchComicDetail(event.comicId);
        emit(ComicDetailLoaded(comic));  // Emit comic details
      } catch (e) {
        emit(ComicError('Failed to load comic details: $e'));  // Emit error state
      }
    });

// Handles the RefreshComicDetail event to force-refresh comic details from the API
    on<RefreshComicDetail>((event, emit) async {
      try {
        emit(ComicLoading());  // Show loading state while refreshing data

        // Force-refresh data from the repository (which handles the API and cache)
        final comic = await repository.refreshComicDetail(event.comicId);
        emit(ComicDetailLoaded(comic));  // Emit refreshed comic details
      } catch (e) {
        emit(ComicError('Failed to refresh comic details: $e'));  // Emit error state
      }
    });


  }
}
