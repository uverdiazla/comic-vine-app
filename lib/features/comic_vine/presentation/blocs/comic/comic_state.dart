import 'package:equatable/equatable.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';

/// Abstract base class for all comic-related states
abstract class ComicState extends Equatable {
  const ComicState();

  @override
  List<Object> get props => [];
}

/// State when comics are being loaded
class ComicLoading extends ComicState {}

/// State when an error occurs during data fetching
class ComicError extends ComicState {
  final String message;

  const ComicError(this.message);

  @override
  List<Object> get props => [message];
}

/// State when the list of comics is successfully loaded
class ComicLoaded extends ComicState {
  final List<ComicModel> comics;

  const ComicLoaded(this.comics);

  @override
  List<Object> get props => [comics];
}

/// State when a specific comic's details are successfully loaded
class ComicDetailLoaded extends ComicState {
  final ComicModel comic;

  const ComicDetailLoaded(this.comic);

  @override
  List<Object> get props => [comic];
}
