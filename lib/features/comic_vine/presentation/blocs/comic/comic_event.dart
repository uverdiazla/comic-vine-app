import 'package:equatable/equatable.dart';

/// Abstract base class for all comic-related events
abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch the list of comics, supporting pagination
class FetchComics extends ComicEvent {
  final int page;

  const FetchComics({required this.page});

  @override
  List<Object> get props => [page];
}


/// Event to fetch details of a specific comic by ID
class FetchComicDetail extends ComicEvent {
  final int comicId;

  const FetchComicDetail(this.comicId);

  @override
  List<Object> get props => [comicId];
}
