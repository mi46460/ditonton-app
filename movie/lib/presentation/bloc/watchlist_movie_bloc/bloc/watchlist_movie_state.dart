part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

final class WatchlistMovieAddRemoveDataSuccess extends WatchlistMovieState {
  final String message;

  const WatchlistMovieAddRemoveDataSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class WatchlistMovieAddRemoveDataFailed extends WatchlistMovieState {
  final String message;

  const WatchlistMovieAddRemoveDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class WatchlistMovieDataIsAdded extends WatchlistMovieState {
  final bool status;

  const WatchlistMovieDataIsAdded(this.status);

  @override
  List<Object?> get props => [status];
}

final class WatchlistMovieLoading extends WatchlistMovieState {}

final class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movies;

  const WatchlistMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}

final class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}
